Return-Path: <linux-s390+bounces-9216-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B3FA45F77
	for <lists+linux-s390@lfdr.de>; Wed, 26 Feb 2025 13:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB881188925C
	for <lists+linux-s390@lfdr.de>; Wed, 26 Feb 2025 12:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6880D21884A;
	Wed, 26 Feb 2025 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BfKM0Q3d"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BAE1DFF8;
	Wed, 26 Feb 2025 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573461; cv=none; b=g+creSTsCZ7SSv9QiZ25B+/OzDNyz1HG9yKrHUoOKDS8zIXv6t+4JjH26Ww1XVV2jHnyk6VwcGn/z6v1ahJN41TLMB9O5bMBnCd9iTZRXZDT5Rf+klIlOwBN28aweGr1/ASpAfwxISIHSPQwPzd0It+5PyC9JSMR5QvB2ixOFoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573461; c=relaxed/simple;
	bh=mKN5SoUkR4/5AJFb40laCctekOjxYDUYSZsINu5WVS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuO+BII7GvbUril9TBBStN4GxZbFIdW8ZZz2VEf7Umu7blONm52iHyknriO2P9sN25fqHAAbu7BoMZMZU4FQvGSKQVpbEz4dVo/OcGVonTHgmRz2IX8CJ45qf9R6uVy+hjwPeva7jZGO0L/YgYBHumjnimzDpwXhyEHaP7G6jE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BfKM0Q3d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q7WgRe005895;
	Wed, 26 Feb 2025 12:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xB3yYs2Iq3nA/8v23
	H2KTqh4IiUbxZFaulVoXTuv8KQ=; b=BfKM0Q3dmG+LMri2eJyIlaAnD7VvJeBrb
	hwBKo0T7LqXtkz9lV+ICARRH/3y4a7nRuij+rZsggP50BKAFHfisgXs37GHtEXcj
	GJnz6Q/x/kJvz32f/AVIyQyYLDLZOCPgMx+hdfTTWKuOOH8H9oIWWk9FzUHL8wKA
	s+7WA/7BMvoJgfupZkcAymi3l4+phhRcSz4yvQDXW94rNTDvagbT7Sbkb/0VDT5C
	JuCMRoQnSY2wDUHaODKDdd6fa3NizquVF1jOA9T5iTdUcR9o7C4NEfPrAMmA1d0E
	FJzAc+9pYtgDVJhokJ5kAbHZ3yr9fQePtHlI/8N0q1EHATiKz/aLA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451xnp198w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:37:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QCSEUL026404;
	Wed, 26 Feb 2025 12:37:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswnjkjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 12:37:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QCbWRV48497054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 12:37:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BC1C2004B;
	Wed, 26 Feb 2025 12:37:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F09220040;
	Wed, 26 Feb 2025 12:37:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.9.246])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 12:37:31 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, borntraeger@de.ibm.com, david@redhat.com,
        nrb@linux.ibm.com, seiden@linux.ibm.com, nsg@linux.ibm.com,
        schlameuss@linux.ibm.com, hca@linux.ibm.com
Subject: [PATCH v2 1/1] KVM: s390: pv: fix race when making a page secure
Date: Wed, 26 Feb 2025 13:37:25 +0100
Message-ID: <20250226123725.247578-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226123725.247578-1-imbrenda@linux.ibm.com>
References: <20250226123725.247578-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M4rQPuTgZcwr3bEXJMPlGGCv-9BXGWWk
X-Proofpoint-GUID: M4rQPuTgZcwr3bEXJMPlGGCv-9BXGWWk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260100

Holding the pte lock for the page that is being converted to secure is
needed to avoid races. A previous commit removed the locking, which
caused issues. Fix by locking the pte again.

Fixes: 5cbe24350b7d ("KVM: s390: move pv gmap functions into kvm")
Reported-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/include/asm/uv.h |   2 +-
 arch/s390/kernel/uv.c      | 105 ++++++++++++++++++++++++++++++++++---
 arch/s390/kvm/gmap.c       |  99 +++-------------------------------
 arch/s390/kvm/kvm-s390.c   |  25 +++++----
 4 files changed, 121 insertions(+), 110 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index b11f5b6d0bd1..46fb0ef6f984 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -631,7 +631,7 @@ int uv_pin_shared(unsigned long paddr);
 int uv_destroy_folio(struct folio *folio);
 int uv_destroy_pte(pte_t pte);
 int uv_convert_from_secure_pte(pte_t pte);
-int make_folio_secure(struct folio *folio, struct uv_cb_header *uvcb);
+int make_hva_secure(struct mm_struct *mm, unsigned long hva, struct uv_cb_header *uvcb);
 int uv_convert_from_secure(unsigned long paddr);
 int uv_convert_from_secure_folio(struct folio *folio);
 
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 9f05df2da2f7..6c6e81daa839 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -206,6 +206,39 @@ int uv_convert_from_secure_pte(pte_t pte)
 	return uv_convert_from_secure_folio(pfn_folio(pte_pfn(pte)));
 }
 
+/**
+ * should_export_before_import - Determine whether an export is needed
+ * before an import-like operation
+ * @uvcb: the Ultravisor control block of the UVC to be performed
+ * @mm: the mm of the process
+ *
+ * Returns whether an export is needed before every import-like operation.
+ * This is needed for shared pages, which don't trigger a secure storage
+ * exception when accessed from a different guest.
+ *
+ * Although considered as one, the Unpin Page UVC is not an actual import,
+ * so it is not affected.
+ *
+ * No export is needed also when there is only one protected VM, because the
+ * page cannot belong to the wrong VM in that case (there is no "other VM"
+ * it can belong to).
+ *
+ * Return: true if an export is needed before every import, otherwise false.
+ */
+static bool should_export_before_import(struct uv_cb_header *uvcb, struct mm_struct *mm)
+{
+	/*
+	 * The misc feature indicates, among other things, that importing a
+	 * shared page from a different protected VM will automatically also
+	 * transfer its ownership.
+	 */
+	if (uv_has_feature(BIT_UV_FEAT_MISC))
+		return false;
+	if (uvcb->cmd == UVC_CMD_UNPIN_PAGE_SHARED)
+		return false;
+	return atomic_read(&mm->context.protected_count) > 1;
+}
+
 /*
  * Calculate the expected ref_count for a folio that would otherwise have no
  * further pins. This was cribbed from similar functions in other places in
@@ -228,7 +261,7 @@ static int expected_folio_refs(struct folio *folio)
 }
 
 /**
- * make_folio_secure() - make a folio secure
+ * __make_folio_secure() - make a folio secure
  * @folio: the folio to make secure
  * @uvcb: the uvcb that describes the UVC to be used
  *
@@ -243,14 +276,13 @@ static int expected_folio_refs(struct folio *folio)
  *         -EINVAL if the UVC failed for other reasons.
  *
  * Context: The caller must hold exactly one extra reference on the folio
- *          (it's the same logic as split_folio())
+ *          (it's the same logic as split_folio()), and the folio must be
+ *          locked.
  */
-int make_folio_secure(struct folio *folio, struct uv_cb_header *uvcb)
+static int __make_folio_secure(struct folio *folio, struct uv_cb_header *uvcb)
 {
 	int expected, cc = 0;
 
-	if (folio_test_large(folio))
-		return -E2BIG;
 	if (folio_test_writeback(folio))
 		return -EBUSY;
 	expected = expected_folio_refs(folio) + 1;
@@ -277,7 +309,68 @@ int make_folio_secure(struct folio *folio, struct uv_cb_header *uvcb)
 		return -EAGAIN;
 	return uvcb->rc == 0x10a ? -ENXIO : -EINVAL;
 }
-EXPORT_SYMBOL_GPL(make_folio_secure);
+
+static int make_folio_secure(struct mm_struct *mm, struct folio *folio, struct uv_cb_header *uvcb)
+{
+	int rc;
+
+	if (!folio_trylock(folio))
+		return -EAGAIN;
+	if (should_export_before_import(uvcb, mm))
+		uv_convert_from_secure(folio_to_phys(folio));
+	rc = __make_folio_secure(folio, uvcb);
+	folio_unlock(folio);
+
+	return rc;
+}
+
+static pte_t *get_locked_valid_pte(struct mm_struct *mm, unsigned long hva, spinlock_t **ptl)
+{
+	pte_t *ptep = get_locked_pte(mm, hva, ptl);
+
+	if (ptep && (pte_val(*ptep) & _PAGE_INVALID)) {
+		pte_unmap_unlock(ptep, *ptl);
+		ptep = NULL;
+	}
+	return ptep;
+}
+
+int make_hva_secure(struct mm_struct *mm, unsigned long hva, struct uv_cb_header *uvcb)
+{
+	struct folio *folio;
+	spinlock_t *ptelock;
+	pte_t *ptep;
+	int rc;
+
+	ptep = get_locked_valid_pte(mm, hva, &ptelock);
+	if (!ptep)
+		return -ENXIO;
+
+	folio = page_folio(pte_page(*ptep));
+	folio_get(folio);
+	/*
+	 * Secure pages cannot be huge and userspace should not combine both.
+	 * In case userspace does it anyway this will result in an -EFAULT for
+	 * the unpack. The guest is thus never reaching secure mode.
+	 * If userspace plays dirty tricks and decides to map huge pages at a
+	 * later point in time, it will receive a segmentation fault or
+	 * KVM_RUN will return -EFAULT.
+	 */
+	if (folio_test_hugetlb(folio))
+		rc =  -EFAULT;
+	else if (folio_test_large(folio))
+		rc = -E2BIG;
+	else
+		rc = make_folio_secure(mm, folio, uvcb);
+	pte_unmap_unlock(ptep, ptelock);
+
+	if (rc == -E2BIG || rc == -EBUSY)
+		rc = kvm_s390_wiggle_split_folio(mm, folio, rc == -E2BIG);
+	folio_put(folio);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(make_hva_secure);
 
 /*
  * To be called with the folio locked or with an extra reference! This will
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 02adf151d4de..c08950b4301c 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -22,92 +22,6 @@
 
 #include "gmap.h"
 
-/**
- * should_export_before_import - Determine whether an export is needed
- * before an import-like operation
- * @uvcb: the Ultravisor control block of the UVC to be performed
- * @mm: the mm of the process
- *
- * Returns whether an export is needed before every import-like operation.
- * This is needed for shared pages, which don't trigger a secure storage
- * exception when accessed from a different guest.
- *
- * Although considered as one, the Unpin Page UVC is not an actual import,
- * so it is not affected.
- *
- * No export is needed also when there is only one protected VM, because the
- * page cannot belong to the wrong VM in that case (there is no "other VM"
- * it can belong to).
- *
- * Return: true if an export is needed before every import, otherwise false.
- */
-static bool should_export_before_import(struct uv_cb_header *uvcb, struct mm_struct *mm)
-{
-	/*
-	 * The misc feature indicates, among other things, that importing a
-	 * shared page from a different protected VM will automatically also
-	 * transfer its ownership.
-	 */
-	if (uv_has_feature(BIT_UV_FEAT_MISC))
-		return false;
-	if (uvcb->cmd == UVC_CMD_UNPIN_PAGE_SHARED)
-		return false;
-	return atomic_read(&mm->context.protected_count) > 1;
-}
-
-static int __gmap_make_secure(struct gmap *gmap, struct page *page, void *uvcb)
-{
-	struct folio *folio = page_folio(page);
-	int rc;
-
-	/*
-	 * Secure pages cannot be huge and userspace should not combine both.
-	 * In case userspace does it anyway this will result in an -EFAULT for
-	 * the unpack. The guest is thus never reaching secure mode.
-	 * If userspace plays dirty tricks and decides to map huge pages at a
-	 * later point in time, it will receive a segmentation fault or
-	 * KVM_RUN will return -EFAULT.
-	 */
-	if (folio_test_hugetlb(folio))
-		return -EFAULT;
-	if (folio_test_large(folio)) {
-		mmap_read_unlock(gmap->mm);
-		rc = kvm_s390_wiggle_split_folio(gmap->mm, folio, true);
-		mmap_read_lock(gmap->mm);
-		if (rc)
-			return rc;
-		folio = page_folio(page);
-	}
-
-	if (!folio_trylock(folio))
-		return -EAGAIN;
-	if (should_export_before_import(uvcb, gmap->mm))
-		uv_convert_from_secure(folio_to_phys(folio));
-	rc = make_folio_secure(folio, uvcb);
-	folio_unlock(folio);
-
-	/*
-	 * In theory a race is possible and the folio might have become
-	 * large again before the folio_trylock() above. In that case, no
-	 * action is performed and -EAGAIN is returned; the callers will
-	 * have to try again later.
-	 * In most cases this implies running the VM again, getting the same
-	 * exception again, and make another attempt in this function.
-	 * This is expected to happen extremely rarely.
-	 */
-	if (rc == -E2BIG)
-		return -EAGAIN;
-	/* The folio has too many references, try to shake some off */
-	if (rc == -EBUSY) {
-		mmap_read_unlock(gmap->mm);
-		kvm_s390_wiggle_split_folio(gmap->mm, folio, false);
-		mmap_read_lock(gmap->mm);
-		return -EAGAIN;
-	}
-
-	return rc;
-}
-
 /**
  * gmap_make_secure() - make one guest page secure
  * @gmap: the guest gmap
@@ -120,17 +34,16 @@ static int __gmap_make_secure(struct gmap *gmap, struct page *page, void *uvcb)
 int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 {
 	struct kvm *kvm = gmap->private;
-	struct page *page;
+	unsigned long vmaddr;
 	int rc = 0;
 
 	lockdep_assert_held(&kvm->srcu);
 
-	page = gfn_to_page(kvm, gpa_to_gfn(gaddr));
-	mmap_read_lock(gmap->mm);
-	if (page)
-		rc = __gmap_make_secure(gmap, page, uvcb);
-	kvm_release_page_clean(page);
-	mmap_read_unlock(gmap->mm);
+	vmaddr = gfn_to_hva(kvm, gpa_to_gfn(gaddr));
+	if (kvm_is_error_hva(vmaddr))
+		rc = -ENXIO;
+	else
+		rc = make_hva_secure(gmap->mm, vmaddr, uvcb);
 
 	return rc;
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ebecb96bacce..020502af7dc9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4952,6 +4952,7 @@ static int vcpu_post_run_handle_fault(struct kvm_vcpu *vcpu)
 {
 	unsigned int flags = 0;
 	unsigned long gaddr;
+	int rc;
 
 	gaddr = current->thread.gmap_teid.addr * PAGE_SIZE;
 	if (kvm_s390_cur_gmap_fault_is_write())
@@ -4961,16 +4962,6 @@ static int vcpu_post_run_handle_fault(struct kvm_vcpu *vcpu)
 	case 0:
 		vcpu->stat.exit_null++;
 		break;
-	case PGM_NON_SECURE_STORAGE_ACCESS:
-		kvm_s390_assert_primary_as(vcpu);
-		/*
-		 * This is normal operation; a page belonging to a protected
-		 * guest has not been imported yet. Try to import the page into
-		 * the protected guest.
-		 */
-		if (gmap_convert_to_secure(vcpu->arch.gmap, gaddr) == -EINVAL)
-			send_sig(SIGSEGV, current, 0);
-		break;
 	case PGM_SECURE_STORAGE_ACCESS:
 	case PGM_SECURE_STORAGE_VIOLATION:
 		kvm_s390_assert_primary_as(vcpu);
@@ -4995,6 +4986,20 @@ static int vcpu_post_run_handle_fault(struct kvm_vcpu *vcpu)
 			send_sig(SIGSEGV, current, 0);
 		}
 		break;
+	case PGM_NON_SECURE_STORAGE_ACCESS:
+		kvm_s390_assert_primary_as(vcpu);
+		/*
+		 * This is normal operation; a page belonging to a protected
+		 * guest has not been imported yet. Try to import the page into
+		 * the protected guest.
+		 */
+		rc = gmap_convert_to_secure(vcpu->arch.gmap, gaddr);
+		if (rc == -EINVAL)
+			send_sig(SIGSEGV, current, 0);
+		if (rc != -ENXIO)
+			break;
+		flags = FAULT_FLAG_WRITE;
+		fallthrough;
 	case PGM_PROTECTION:
 	case PGM_SEGMENT_TRANSLATION:
 	case PGM_PAGE_TRANSLATION:
-- 
2.48.1


