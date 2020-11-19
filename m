Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AB92B93F9
	for <lists+linux-s390@lfdr.de>; Thu, 19 Nov 2020 14:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgKSN5a (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Nov 2020 08:57:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33826 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgKSN53 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Nov 2020 08:57:29 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605794247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HP59II7Pvu7wtmnPAAa6QlVbhh9UsZmUWYVIo7PqK9Q=;
        b=LnZKkef7IeJhaMkPNfWaMaQB8lwLtOaiz58/fPvwYpapYsG8tdUeMAwfTX82wOtbpmsMs/
        0XQ3bhjXqX1PukgP8MCFWKBwV26ReB2wWT2H6lYm/QRfiY8B5dsdiSWyaun+iQ5mQtQbSE
        P4DWi7/KwdBO2SXVlpylDDIW7Ec4iPrg4Y17kwUO0RcO8Ou3v0V/T7urTWUb0BLVwNQpVB
        mQ6AaUO9dh3VmSAIWILoF0qcJFLXqwZ1kJElXrfe/s2mOkKXxQR8cT7wjiw60QZ8+cWL41
        1ik7UiKFH0ZnWOm5JdR9gW06MnGZBcsbkX6RDHtae1HcpifSKXfWCdsMi7Tj5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605794247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HP59II7Pvu7wtmnPAAa6QlVbhh9UsZmUWYVIo7PqK9Q=;
        b=YH23/8HIKAfyN/Ohktxtg2/Wn2M7Cr+z9HHHExBU2t2lMewqvSLeMF4vgxfdJ14pjvcvIc
        Qc26H0+GwpVK+sDg==
To:     linux-s390@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 3/6] s390/ctcm: Avoid temporary allocation of struct pdu.
Date:   Thu, 19 Nov 2020 14:57:15 +0100
Message-Id: <20201119135719.983170-4-bigeasy@linutronix.de>
In-Reply-To: <20201119135719.983170-1-bigeasy@linutronix.de>
References: <20201119135719.983170-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The size of struct pdu is 8 byte. The memory is allocated, initialized,
used and deallocated a few lines later.

It is more efficient to avoid the allocation/free dance and assign the
values directly to skb's data part instead of using memcpy() for it.

Avoid an allocation of struct pdu and use the resulting skb pointer instead.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/net/ctcm_main.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index a3a74ebfee635..0cb130c280031 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -666,24 +666,16 @@ static int ctcmpc_transmit_skb(struct channel *ch, st=
ruct sk_buff *skb)
 	if ((fsm_getstate(ch->fsm) !=3D CTC_STATE_TXIDLE) || grp->in_sweep) {
 		spin_lock_irqsave(&ch->collect_lock, saveflags);
 		refcount_inc(&skb->users);
-		p_header =3D kmalloc(PDU_HEADER_LENGTH, gfp_type());
-
-		if (!p_header) {
-			spin_unlock_irqrestore(&ch->collect_lock, saveflags);
-				goto nomem_exit;
-		}
=20
+		p_header =3D skb_push(skb, PDU_HEADER_LENGTH);
 		p_header->pdu_offset =3D skb->len;
 		p_header->pdu_proto =3D 0x01;
-		p_header->pdu_flag =3D 0x00;
 		if (be16_to_cpu(skb->protocol) =3D=3D ETH_P_SNAP) {
-			p_header->pdu_flag |=3D PDU_FIRST | PDU_CNTL;
+			p_header->pdu_flag =3D PDU_FIRST | PDU_CNTL;
 		} else {
-			p_header->pdu_flag |=3D PDU_FIRST;
+			p_header->pdu_flag =3D PDU_FIRST;
 		}
 		p_header->pdu_seq =3D 0;
-		memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header,
-		       PDU_HEADER_LENGTH);
=20
 		CTCM_PR_DEBUG("%s(%s): Put on collect_q - skb len: %04x \n"
 				"pdu header and data for up to 32 bytes:\n",
@@ -692,7 +684,6 @@ static int ctcmpc_transmit_skb(struct channel *ch, stru=
ct sk_buff *skb)
=20
 		skb_queue_tail(&ch->collect_queue, skb);
 		ch->collect_len +=3D skb->len;
-		kfree(p_header);
=20
 		spin_unlock_irqrestore(&ch->collect_lock, saveflags);
 			goto done;
@@ -722,23 +713,15 @@ static int ctcmpc_transmit_skb(struct channel *ch, st=
ruct sk_buff *skb)
 		}
 	}
=20
-	p_header =3D kmalloc(PDU_HEADER_LENGTH, gfp_type());
-
-	if (!p_header)
-		goto nomem_exit;
-
+	p_header =3D skb_push(skb, PDU_HEADER_LENGTH);
 	p_header->pdu_offset =3D skb->len;
 	p_header->pdu_proto =3D 0x01;
-	p_header->pdu_flag =3D 0x00;
 	p_header->pdu_seq =3D 0;
 	if (be16_to_cpu(skb->protocol) =3D=3D ETH_P_SNAP) {
-		p_header->pdu_flag |=3D PDU_FIRST | PDU_CNTL;
+		p_header->pdu_flag =3D PDU_FIRST | PDU_CNTL;
 	} else {
-		p_header->pdu_flag |=3D PDU_FIRST;
+		p_header->pdu_flag =3D PDU_FIRST;
 	}
-	memcpy(skb_push(skb, PDU_HEADER_LENGTH), p_header, PDU_HEADER_LENGTH);
-
-	kfree(p_header);
=20
 	if (ch->collect_len > 0) {
 		spin_lock_irqsave(&ch->collect_lock, saveflags);
--=20
2.29.2

