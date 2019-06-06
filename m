Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1572737362
	for <lists+linux-s390@lfdr.de>; Thu,  6 Jun 2019 13:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfFFLvq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 6 Jun 2019 07:51:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728414AbfFFLvq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Jun 2019 07:51:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56BlpIj072778
        for <linux-s390@vger.kernel.org>; Thu, 6 Jun 2019 07:51:45 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sy1s3sj70-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 06 Jun 2019 07:51:45 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 6 Jun 2019 12:51:43 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 6 Jun 2019 12:51:40 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x56Bpcnn25493578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Jun 2019 11:51:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B12F4AE04D;
        Thu,  6 Jun 2019 11:51:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08958AE057;
        Thu,  6 Jun 2019 11:51:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  6 Jun 2019 11:51:37 +0000 (GMT)
From:   Halil Pasic <pasic@linux.ibm.com>
To:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        "Jason J. Herne" <jjherne@linux.ibm.com>
Subject: [PATCH v4 4/8] s390/airq: use DMA memory for adapter interrupts
Date:   Thu,  6 Jun 2019 13:51:23 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606115127.55519-1-pasic@linux.ibm.com>
References: <20190606115127.55519-1-pasic@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19060611-0008-0000-0000-000002F07A59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060611-0009-0000-0000-0000225D6642
Message-Id: <20190606115127.55519-5-pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=991 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060087
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Protected virtualization guests have to use shared pages for airq
notifier bit vectors, because hypervisor needs to write these bits.

Let us make sure we allocate DMA memory for the notifier bit vectors by
replacing the kmem_cache with a dma_cache and kalloc() with
cio_dma_zalloc().

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
---
 arch/s390/include/asm/airq.h |  2 ++
 drivers/s390/cio/airq.c      | 32 ++++++++++++++++++++------------
 drivers/s390/cio/cio.h       |  2 ++
 drivers/s390/cio/css.c       |  1 +
 4 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/airq.h b/arch/s390/include/asm/airq.h
index c10d2ee2dfda..01936fdfaddb 100644
--- a/arch/s390/include/asm/airq.h
+++ b/arch/s390/include/asm/airq.h
@@ -11,6 +11,7 @@
 #define _ASM_S390_AIRQ_H
 
 #include <linux/bit_spinlock.h>
+#include <linux/dma-mapping.h>
 
 struct airq_struct {
 	struct hlist_node list;		/* Handler queueing. */
@@ -29,6 +30,7 @@ void unregister_adapter_interrupt(struct airq_struct *airq);
 /* Adapter interrupt bit vector */
 struct airq_iv {
 	unsigned long *vector;	/* Adapter interrupt bit vector */
+	dma_addr_t vector_dma; /* Adapter interrupt bit vector dma */
 	unsigned long *avail;	/* Allocation bit mask for the bit vector */
 	unsigned long *bitlock;	/* Lock bit mask for the bit vector */
 	unsigned long *ptr;	/* Pointer associated with each bit */
diff --git a/drivers/s390/cio/airq.c b/drivers/s390/cio/airq.c
index 4534afc63591..89d26e43004d 100644
--- a/drivers/s390/cio/airq.c
+++ b/drivers/s390/cio/airq.c
@@ -16,9 +16,11 @@
 #include <linux/mutex.h>
 #include <linux/rculist.h>
 #include <linux/slab.h>
+#include <linux/dmapool.h>
 
 #include <asm/airq.h>
 #include <asm/isc.h>
+#include <asm/cio.h>
 
 #include "cio.h"
 #include "cio_debug.h"
@@ -27,7 +29,7 @@
 static DEFINE_SPINLOCK(airq_lists_lock);
 static struct hlist_head airq_lists[MAX_ISC+1];
 
-static struct kmem_cache *airq_iv_cache;
+static struct dma_pool *airq_iv_cache;
 
 /**
  * register_adapter_interrupt() - register adapter interrupt handler
@@ -115,6 +117,11 @@ void __init init_airq_interrupts(void)
 	setup_irq(THIN_INTERRUPT, &airq_interrupt);
 }
 
+static inline unsigned long iv_size(unsigned long bits)
+{
+	return BITS_TO_LONGS(bits) * sizeof(unsigned long);
+}
+
 /**
  * airq_iv_create - create an interrupt vector
  * @bits: number of bits in the interrupt vector
@@ -132,17 +139,18 @@ struct airq_iv *airq_iv_create(unsigned long bits, unsigned long flags)
 		goto out;
 	iv->bits = bits;
 	iv->flags = flags;
-	size = BITS_TO_LONGS(bits) * sizeof(unsigned long);
+	size = iv_size(bits);
 
 	if (flags & AIRQ_IV_CACHELINE) {
 		if ((cache_line_size() * BITS_PER_BYTE) < bits)
 			goto out_free;
 
-		iv->vector = kmem_cache_zalloc(airq_iv_cache, GFP_KERNEL);
+		iv->vector = dma_pool_zalloc(airq_iv_cache, GFP_KERNEL,
+					     &iv->vector_dma);
 		if (!iv->vector)
 			goto out_free;
 	} else {
-		iv->vector = kzalloc(size, GFP_KERNEL);
+		iv->vector = cio_dma_zalloc(size);
 		if (!iv->vector)
 			goto out_free;
 	}
@@ -179,9 +187,9 @@ struct airq_iv *airq_iv_create(unsigned long bits, unsigned long flags)
 	kfree(iv->bitlock);
 	kfree(iv->avail);
 	if (iv->flags & AIRQ_IV_CACHELINE)
-		kmem_cache_free(airq_iv_cache, iv->vector);
+		dma_pool_free(airq_iv_cache, iv->vector, iv->vector_dma);
 	else
-		kfree(iv->vector);
+		cio_dma_free(iv->vector, size);
 	kfree(iv);
 out:
 	return NULL;
@@ -198,9 +206,9 @@ void airq_iv_release(struct airq_iv *iv)
 	kfree(iv->ptr);
 	kfree(iv->bitlock);
 	if (iv->flags & AIRQ_IV_CACHELINE)
-		kmem_cache_free(airq_iv_cache, iv->vector);
+		dma_pool_free(airq_iv_cache, iv->vector, iv->vector_dma);
 	else
-		kfree(iv->vector);
+		cio_dma_free(iv->vector, iv_size(iv->bits));
 	kfree(iv->avail);
 	kfree(iv);
 }
@@ -295,12 +303,12 @@ unsigned long airq_iv_scan(struct airq_iv *iv, unsigned long start,
 }
 EXPORT_SYMBOL(airq_iv_scan);
 
-static int __init airq_init(void)
+int __init airq_init(void)
 {
-	airq_iv_cache = kmem_cache_create("airq_iv_cache", cache_line_size(),
-					  cache_line_size(), 0, NULL);
+	airq_iv_cache = dma_pool_create("airq_iv_cache", cio_get_dma_css_dev(),
+					cache_line_size(),
+					cache_line_size(), PAGE_SIZE);
 	if (!airq_iv_cache)
 		return -ENOMEM;
 	return 0;
 }
-subsys_initcall(airq_init);
diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index 06a91743335a..4d6c7d16416e 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -135,6 +135,8 @@ extern int cio_commit_config(struct subchannel *sch);
 int cio_tm_start_key(struct subchannel *sch, struct tcw *tcw, u8 lpm, u8 key);
 int cio_tm_intrg(struct subchannel *sch);
 
+extern int __init airq_init(void);
+
 /* Use with care. */
 #ifdef CONFIG_CCW_CONSOLE
 extern struct subchannel *cio_probe_console(void);
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 6fc91d534af1..7901c8ed3597 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -1182,6 +1182,7 @@ static int __init css_bus_init(void)
 	ret = cio_dma_pool_init();
 	if (ret)
 		goto out_unregister_pmn;
+	airq_init();
 	css_init_done = 1;
 
 	/* Enable default isc for I/O subchannels. */
-- 
2.17.1

