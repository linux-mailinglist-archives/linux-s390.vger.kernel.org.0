Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF753C591
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jun 2022 09:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbiFCG7C (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Jun 2022 02:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241774AbiFCG5D (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jun 2022 02:57:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAD5100A;
        Thu,  2 Jun 2022 23:56:53 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2536ht1p031430;
        Fri, 3 Jun 2022 06:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z4Iym204eNfQ5u0rOKBwkwCtB2lMQdvt0RvDuKQul7E=;
 b=qN6ZJJ4X8SF+UdRIkjhgMFTZnU1Snb416fM9Faz9pQN7m5V4gvorODKJX4lY05BT6dcX
 +ulxJSV69LhTzjzU2zIymO1zZJMML827xyoZ+HJ2EhBkS7rm454sQmAkh3nVi2Brj9L5
 gUPbRHjn/R4W6J/ajQac5Jbo8jazQKDLHfSCfkfoed6vLzuG4M7m+qM9kLULKtuChZUb
 9qSDOuP81tFurVArqcH04izhopRKfNMsNclYYevuX5bT44Q8M31RzSWVfzSLKg5GYh/K
 IepTZlnClWPD5kTiHrAAcUv+gHezyxJ8ZS1yvdPll/W2GO70iA36XbxwR9ZbeYx2s8e8 Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfd9r85r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 06:56:52 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2536uqJD014309;
        Fri, 3 Jun 2022 06:56:52 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfd9r85qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 06:56:52 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2536of9w027386;
        Fri, 3 Jun 2022 06:56:50 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3gf2afgets-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 06:56:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2536uk0K52166956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2022 06:56:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B356042042;
        Fri,  3 Jun 2022 06:56:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 637DD42045;
        Fri,  3 Jun 2022 06:56:46 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.40])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jun 2022 06:56:46 +0000 (GMT)
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     borntraeger@de.ibm.com, frankja@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, david@redhat.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, scgl@linux.ibm.com,
        mimu@linux.ibm.com, nrb@linux.ibm.com
Subject: [PATCH v11 01/19] KVM: s390: pv: leak the topmost page table when destroy fails
Date:   Fri,  3 Jun 2022 08:56:27 +0200
Message-Id: <20220603065645.10019-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603065645.10019-1-imbrenda@linux.ibm.com>
References: <20220603065645.10019-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wgOXg-iAoCD5A4soMz8_nfEbVmsxJcP9
X-Proofpoint-GUID: ROffwroTjeTjzOp2ymBsdpzIK25YtmCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_01,2022-06-02_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030027
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Each secure guest must have a unique ASCE (address space control
element); we must avoid that new guests use the same page for their
ASCE, to avoid errors.

Since the ASCE mostly consists of the address of the topmost page table
(plus some flags), we must not return that memory to the pool unless
the ASCE is no longer in use.

Only a successful Destroy Secure Configuration UVC will make the ASCE
reusable again.

If the Destroy Configuration UVC fails, the ASCE cannot be reused for a
secure guest (either for the ASCE or for other memory areas). To avoid
a collision, it must not be used again. This is a permanent error and
the page becomes in practice unusable, so we set it aside and leak it.
On failure we already leak other memory that belongs to the ultravisor
(i.e. the variable and base storage for a guest) and not leaking the
topmost page table was an oversight.

This error (and thus the leakage) should not happen unless the hardware
is broken or KVM has some unknown serious bug.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: 29b40f105ec8d55 ("KVM: s390: protvirt: Add initial vm and cpu lifecycle handling")
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/gmap.h |  2 +
 arch/s390/kvm/pv.c           |  9 ++--
 arch/s390/mm/gmap.c          | 86 ++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 40264f60b0da..f4073106e1f3 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -148,4 +148,6 @@ void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long dirty_bitmap[4],
 			     unsigned long gaddr, unsigned long vmaddr);
 int gmap_mark_unmergeable(void);
 void s390_reset_acc(struct mm_struct *mm);
+void s390_unlist_old_asce(struct gmap *gmap);
+int s390_replace_asce(struct gmap *gmap);
 #endif /* _ASM_S390_GMAP_H */
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index cc7c9599f43e..8eee3fc414e5 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -161,10 +161,13 @@ int kvm_s390_pv_deinit_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
 	atomic_set(&kvm->mm->context.is_protected, 0);
 	KVM_UV_EVENT(kvm, 3, "PROTVIRT DESTROY VM: rc %x rrc %x", *rc, *rrc);
 	WARN_ONCE(cc, "protvirt destroy vm failed rc %x rrc %x", *rc, *rrc);
-	/* Inteded memory leak on "impossible" error */
-	if (!cc)
+	/* Intended memory leak on "impossible" error */
+	if (!cc) {
 		kvm_s390_pv_dealloc_vm(kvm);
-	return cc ? -EIO : 0;
+		return 0;
+	}
+	s390_replace_asce(kvm->arch.gmap);
+	return -EIO;
 }
 
 int kvm_s390_pv_init_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 1ac73917a8d3..bd07157f834f 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2721,3 +2721,89 @@ void s390_reset_acc(struct mm_struct *mm)
 	mmput(mm);
 }
 EXPORT_SYMBOL_GPL(s390_reset_acc);
+
+/**
+ * s390_unlist_old_asce - Remove the topmost level of page tables from the
+ * list of page tables of the gmap.
+ * @gmap the gmap whose table is to be removed
+ *
+ * On s390x, KVM keeps a list of all pages containing the page tables of the
+ * gmap (the CRST list). This list is used at tear down time to free all
+ * pages that are now not needed anymore.
+ *
+ * This function removes the topmost page of the tree (the one pointed to by
+ * the ASCE) from the CRST list.
+ *
+ * This means that it will not be freed when the VM is torn down, and needs
+ * to be handled separately by the caller, unless a leak is actually
+ * intended. Notice that this function will only remove the page from the
+ * list, the page will still be used as a top level page table (and ASCE).
+ */
+void s390_unlist_old_asce(struct gmap *gmap)
+{
+	struct page *old;
+
+	old = virt_to_page(gmap->table);
+	spin_lock(&gmap->guest_table_lock);
+	list_del(&old->lru);
+	/*
+	 * Sometimes the topmost page might need to be "removed" multiple
+	 * times, for example if the VM is rebooted into secure mode several
+	 * times concurrently, or if s390_replace_asce fails after calling
+	 * s390_remove_old_asce and is attempted again later. In that case
+	 * the old asce has been removed from the list, and therefore it
+	 * will not be freed when the VM terminates, but the ASCE is still
+	 * in use and still pointed to.
+	 * A subsequent call to replace_asce will follow the pointer and try
+	 * to remove the same page from the list again.
+	 * Therefore it's necessary that the page of the ASCE has valid
+	 * pointers, so list_del can work (and do nothing) without
+	 * dereferencing stale or invalid pointers.
+	 */
+	INIT_LIST_HEAD(&old->lru);
+	spin_unlock(&gmap->guest_table_lock);
+}
+EXPORT_SYMBOL_GPL(s390_unlist_old_asce);
+
+/**
+ * s390_replace_asce - Try to replace the current ASCE of a gmap with a copy
+ * @gmap the gmap whose ASCE needs to be replaced
+ *
+ * If the allocation of the new top level page table fails, the ASCE is not
+ * replaced.
+ * In any case, the old ASCE is always removed from the gmap CRST list.
+ * Therefore the caller has to make sure to save a pointer to it
+ * beforehand, unless a leak is actually intended.
+ */
+int s390_replace_asce(struct gmap *gmap)
+{
+	unsigned long asce;
+	struct page *page;
+	void *table;
+
+	s390_unlist_old_asce(gmap);
+
+	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
+	if (!page)
+		return -ENOMEM;
+	table = page_to_virt(page);
+	memcpy(table, gmap->table, 1UL << (CRST_ALLOC_ORDER + PAGE_SHIFT));
+
+	/*
+	 * The caller has to deal with the old ASCE, but here we make sure
+	 * the new one is properly added to the CRST list, so that
+	 * it will be freed when the VM is torn down.
+	 */
+	spin_lock(&gmap->guest_table_lock);
+	list_add(&page->lru, &gmap->crst_list);
+	spin_unlock(&gmap->guest_table_lock);
+
+	/* Set new table origin while preserving existing ASCE control bits */
+	asce = (gmap->asce & ~_ASCE_ORIGIN) | __pa(table);
+	WRITE_ONCE(gmap->asce, asce);
+	WRITE_ONCE(gmap->mm->context.gmap_asce, asce);
+	WRITE_ONCE(gmap->table, table);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(s390_replace_asce);
-- 
2.36.1

