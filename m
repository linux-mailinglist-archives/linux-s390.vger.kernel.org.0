Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A26CEFADA2
	for <lists+linux-s390@lfdr.de>; Wed, 13 Nov 2019 10:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfKMJx2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 13 Nov 2019 04:53:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26784 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725996AbfKMJx2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 04:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573638806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+GbhqL6RJvOczjYdsKQPhYswGZyvYzUPBvRfiQtglJo=;
        b=fFKX+FHhQ5vdQ5Am7J20qJsV4B+H+uRTSIgTMoXRT9F6iB4A9pV/6sIx9HvrJjmPPJrkF8
        4rLvwsNd5rDao1kttjYx9t8/Ge7LHoIdKOlwRw3QR1/UKTNUhMeoEgu+PttuNqcmk4ATRY
        +IOSJ6kYAtCDHSgGfbbBW/CHMbSX+E4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-B-PtXYtjOU2jsjeCcgqtaQ-1; Wed, 13 Nov 2019 04:53:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6409100551D;
        Wed, 13 Nov 2019 09:53:21 +0000 (UTC)
Received: from localhost (dhcp-192-218.str.redhat.com [10.33.192.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8599C60FC2;
        Wed, 13 Nov 2019 09:53:21 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] s390: vfio-ap: fix some comments
Date:   Wed, 13 Nov 2019 10:53:19 +0100
Message-Id: <20191113095319.6154-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: B-PtXYtjOU2jsjeCcgqtaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The functions are called vfio_ap_irq_{en,dis}able.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

Just some minor stuff I noted while grepping for something.

---
 drivers/s390/crypto/vfio_ap_ops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_a=
p_ops.c
index 5c0f53c6dde7..f8f3f3a4e5fd 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -182,7 +182,7 @@ struct ap_queue_status vfio_ap_irq_disable(struct vfio_=
ap_queue *q)
 }
=20
 /**
- * vfio_ap_setirq: Enable Interruption for a APQN
+ * vfio_ap_irq_enable: Enable Interruption for a APQN
  *
  * @dev: the device associated with the ap_queue
  * @q:=09 the vfio_ap_queue holding AQIC parameters
@@ -265,7 +265,7 @@ static struct ap_queue_status vfio_ap_irq_enable(struct=
 vfio_ap_queue *q,
  * - AP_RESPONSE_Q_NOT_AVAIL: if the queue is not available
  * - AP_RESPONSE_DECONFIGURED: if the queue is not configured
  * - AP_RESPONSE_NORMAL (0) : in case of successs
- *   Check vfio_ap_setirq() and vfio_ap_clrirq() for other possible RC.
+ *   Check vfio_ap_irq_enable() and vfio_ap_irq_disable() for other possib=
le RC.
  * We take the matrix_dev lock to ensure serialization on queues and
  * mediated device access.
  *
--=20
2.21.0

