Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57CB02BA4AD
	for <lists+linux-s390@lfdr.de>; Fri, 20 Nov 2020 09:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgKTIbx (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 20 Nov 2020 03:31:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39052 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgKTIbw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 Nov 2020 03:31:52 -0500
Date:   Fri, 20 Nov 2020 09:31:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605861111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PrQE5oEEtk/6vPUY/vzRoc4zvQLPDXwLobvMwbwdFbs=;
        b=mCf+4DpjQysFkj4PkOJbhMLvcKpga6IV1L5SIt+wlWhs15WaTkpVmjjM0RVF+M5PS8IXdA
        wNyKMe2fP+kk0O0L9eth7v44ZUX/yADJ5KuLqhpP808f1HQHjpE/PourO5/fBNh+d2nndj
        i0OJR2sRdsKWXNAs70oESq9m5YimHHeFNpzKfmpN9uWSj1+RRx2ui0yDFI5yU53haApC33
        bZSsezviL+PIv+2sq37+swSMYLP9YKR5RV1Kc9EL7e0A03RDl0sh/eEPeHBe3rvGDcZQ56
        PQP6KIBXE1e7TtEYAI46FDUZChx/Jf7PLOldhsC2G0+6RODQ4usWLGPkuVuAhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605861111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PrQE5oEEtk/6vPUY/vzRoc4zvQLPDXwLobvMwbwdFbs=;
        b=bCVIDD36jMp56VC3FxXVe37X1V9hGsz0I8/qL1MLvKpAkZwKf8lDQxBshdwHvQkLsjowxn
        FbGQuBbC1xVxxSCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 3/6] s390/ctcm: Avoid temporary allocation of struct
 pdu.
Message-ID: <20201120083149.vwqpkufo7ddmkrlz@linutronix.de>
References: <20201119135719.983170-1-bigeasy@linutronix.de>
 <20201119135719.983170-4-bigeasy@linutronix.de>
 <a20c5577-b217-68b1-f433-51dc0843aa37@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a20c5577-b217-68b1-f433-51dc0843aa37@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2020-11-20 10:05:45 [+0200], Julian Wiedmann wrote:
> > diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
> > index a3a74ebfee635..0cb130c280031 100644
> > --- a/drivers/s390/net/ctcm_main.c
> > +++ b/drivers/s390/net/ctcm_main.c
> > @@ -666,24 +666,16 @@ static int ctcmpc_transmit_skb(struct channel *ch, struct sk_buff *skb)
> >  	if ((fsm_getstate(ch->fsm) != CTC_STATE_TXIDLE) || grp->in_sweep) {
> >  		spin_lock_irqsave(&ch->collect_lock, saveflags);
> >  		refcount_inc(&skb->users);
> > -		p_header = kmalloc(PDU_HEADER_LENGTH, gfp_type());
> > -
> > -		if (!p_header) {
> > -			spin_unlock_irqrestore(&ch->collect_lock, saveflags);
> > -				goto nomem_exit;
> > -		}
> >  
> > +		p_header = skb_push(skb, PDU_HEADER_LENGTH);
> >  		p_header->pdu_offset = skb->len;
> 
> I mentioned this in my reply to v1 - here we now need to adjust skb->len
> for the pushed length. Will fix up while applying (also below).

I'm sorry. It took me a while to understand what you meant and then I
forgot about it while I was here.
Thank you for taking care of it.

Sebastian
