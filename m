Return-Path: <linux-s390+bounces-8368-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D874DA13928
	for <lists+linux-s390@lfdr.de>; Thu, 16 Jan 2025 12:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686AB3A7CA7
	for <lists+linux-s390@lfdr.de>; Thu, 16 Jan 2025 11:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C794C1DEFE8;
	Thu, 16 Jan 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WX8UsHNB"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC191DE3DE;
	Thu, 16 Jan 2025 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027253; cv=none; b=f6q3OmUsjcblII+6Llf+lOvufRH9dEclmwsnbp3ZW9PnYwFfbKmnR3G0iwthu5PNNV0mYLRMZYhaX1vmQ0Qk7baGPk/WBiwDs2Xq34bgVeU6um1GIo1FzsSJT+MrLaJl9a/Rj3aLWUBR9lh6URXJDmjwKSv488h5JDenjLKFa9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027253; c=relaxed/simple;
	bh=vxEJnxZx8MPkSGLjwSKjVZ0SVoZthQwWWC2oF6onCDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foOzrhuum1RERjhtvLC26sdOtiJQGz+8MvAfBLGLy03rUMCibppirE9ZG+Y0rh+o2uLyvUE4z5RwbZDgpd2abOwr+ONqWGHyD5siqsJmwmrkOT20d/9MMB/R7ow7xGIZMhetUwqPD57OMDsG/a5lE1ljUr8H+4FGL76T7QxrXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WX8UsHNB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FNaSic022769;
	Thu, 16 Jan 2025 11:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mWO5OoZ6s445OGuh5
	nejXxjtkjHLvpzDZyfIppUr/yc=; b=WX8UsHNB4QECs8EjUVog/KqaZ9P7YzfTb
	4VO2enq/zBNGi59mFQTyNhNfwlups/yLVRbn3z0yxxQ91gBZf+P14tRdpmPlneH2
	3vI6SgA+lAErc6wPzdgjx8bavznqK+v8BkhYn3tJhQe4PuC27filOVrVybqDdNRO
	VfGU9Q7pVOlz2//oBMsG2vjQDQeNXi4R/6fUu0XPIi6/+VYu7Urgb/6aJRzNjAz+
	Sc6L5ztJMZqVOTNAwau8tJepqU9WYWAz7UbgsVXR+RRnX6Y2YmH1gEzM0XIrt6yE
	2vsxooGWGkHIQCiSRUTjnFHvIMbpSZBu3c8ZV6QLZuTVxL+oF+63w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446pub2qrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:34:03 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GBY3gm027288;
	Thu, 16 Jan 2025 11:34:03 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446pub2qr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:34:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50G9t5oh007385;
	Thu, 16 Jan 2025 11:34:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443yndk9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 11:34:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GBXxAv65143226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 11:33:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA07820049;
	Thu, 16 Jan 2025 11:33:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A4812004B;
	Thu, 16 Jan 2025 11:33:58 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 11:33:58 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, borntraeger@de.ibm.com,
        schlameuss@linux.ibm.com, david@redhat.com, willy@infradead.org,
        hca@linux.ibm.com, svens@linux.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com, nrb@linux.ibm.com, nsg@linux.ibm.com,
        seanjc@google.com, seiden@linux.ibm.com
Subject: [PATCH v2 09/15] KVM: s390: move some gmap shadowing functions away from mm/gmap.c
Date: Thu, 16 Jan 2025 12:33:49 +0100
Message-ID: <20250116113355.32184-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116113355.32184-1-imbrenda@linux.ibm.com>
References: <20250116113355.32184-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZRfQNNrhQOySX32m_OAjUeGyJgbwz03I
X-Proofpoint-ORIG-GUID: 6js4VuOM3VbzXCXhT2djusBVDd5SYZNg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160086

Move some gmap shadowing functions from mm/gmap.c to kvm/kvm-s390.c and
the newly created kvm/gmap-vsie.c

This is a step toward removing gmap from mm.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/include/asm/gmap.h |   9 +-
 arch/s390/kvm/Makefile       |   2 +-
 arch/s390/kvm/gmap-vsie.c    | 142 +++++++++++++++++++++
 arch/s390/kvm/gmap.h         |  20 +++
 arch/s390/kvm/kvm-s390.c     |  62 +++++++++-
 arch/s390/kvm/kvm-s390.h     |   2 +
 arch/s390/kvm/vsie.c         |   2 +
 arch/s390/mm/gmap.c          | 232 ++++-------------------------------
 8 files changed, 254 insertions(+), 217 deletions(-)
 create mode 100644 arch/s390/kvm/gmap-vsie.c

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 3652d8523e1f..2432c47d36db 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -106,6 +106,8 @@ struct gmap *gmap_create(struct mm_struct *mm, unsigned long limit);
 void gmap_remove(struct gmap *gmap);
 struct gmap *gmap_get(struct gmap *gmap);
 void gmap_put(struct gmap *gmap);
+void gmap_free(struct gmap *gmap);
+struct gmap *gmap_alloc(unsigned long limit);
 
 int gmap_map_segment(struct gmap *gmap, unsigned long from,
 		     unsigned long to, unsigned long len);
@@ -118,9 +120,7 @@ void gmap_unlink(struct mm_struct *, unsigned long *table, unsigned long vmaddr)
 
 int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val);
 
-struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
-			 int edat_level);
-int gmap_shadow_valid(struct gmap *sg, unsigned long asce, int edat_level);
+void gmap_unshadow(struct gmap *sg);
 int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 		    int fake);
 int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
@@ -136,8 +136,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte);
 void gmap_register_pte_notifier(struct gmap_notifier *);
 void gmap_unregister_pte_notifier(struct gmap_notifier *);
 
-int gmap_mprotect_notify(struct gmap *, unsigned long start,
-			 unsigned long len, int prot);
+int gmap_protect_one(struct gmap *gmap, unsigned long gaddr, int prot, unsigned long bits);
 
 void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long dirty_bitmap[4],
 			     unsigned long gaddr, unsigned long vmaddr);
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index d972dea657fd..f0ffe874adc2 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -8,7 +8,7 @@ include $(srctree)/virt/kvm/Makefile.kvm
 ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
 
 kvm-y += kvm-s390.o intercept.o interrupt.o priv.o sigp.o
-kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o gmap.o
+kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o gmap.o gmap-vsie.o
 
 kvm-$(CONFIG_VFIO_PCI_ZDEV_KVM) += pci.o
 obj-$(CONFIG_KVM) += kvm.o
diff --git a/arch/s390/kvm/gmap-vsie.c b/arch/s390/kvm/gmap-vsie.c
new file mode 100644
index 000000000000..90427f114995
--- /dev/null
+++ b/arch/s390/kvm/gmap-vsie.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Guest memory management for KVM/s390 nested VMs.
+ *
+ * Copyright IBM Corp. 2008, 2020, 2024
+ *
+ *    Author(s): Claudio Imbrenda <imbrenda@linux.ibm.com>
+ *               Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *               David Hildenbrand <david@redhat.com>
+ *               Janosch Frank <frankja@linux.vnet.ibm.com>
+ */
+
+#include <linux/compiler.h>
+#include <linux/kvm.h>
+#include <linux/kvm_host.h>
+#include <linux/pgtable.h>
+#include <linux/pagemap.h>
+#include <linux/mman.h>
+
+#include <asm/lowcore.h>
+#include <asm/gmap.h>
+#include <asm/uv.h>
+
+#include "kvm-s390.h"
+#include "gmap.h"
+
+/**
+ * gmap_find_shadow - find a specific asce in the list of shadow tables
+ * @parent: pointer to the parent gmap
+ * @asce: ASCE for which the shadow table is created
+ * @edat_level: edat level to be used for the shadow translation
+ *
+ * Returns the pointer to a gmap if a shadow table with the given asce is
+ * already available, ERR_PTR(-EAGAIN) if another one is just being created,
+ * otherwise NULL
+ */
+static struct gmap *gmap_find_shadow(struct gmap *parent, unsigned long asce,
+				     int edat_level)
+{
+	struct gmap *sg;
+
+	list_for_each_entry(sg, &parent->children, list) {
+		if (sg->orig_asce != asce || sg->edat_level != edat_level ||
+		    sg->removed)
+			continue;
+		if (!sg->initialized)
+			return ERR_PTR(-EAGAIN);
+		refcount_inc(&sg->ref_count);
+		return sg;
+	}
+	return NULL;
+}
+
+/**
+ * gmap_shadow - create/find a shadow guest address space
+ * @parent: pointer to the parent gmap
+ * @asce: ASCE for which the shadow table is created
+ * @edat_level: edat level to be used for the shadow translation
+ *
+ * The pages of the top level page table referred by the asce parameter
+ * will be set to read-only and marked in the PGSTEs of the kvm process.
+ * The shadow table will be removed automatically on any change to the
+ * PTE mapping for the source table.
+ *
+ * Returns a guest address space structure, ERR_PTR(-ENOMEM) if out of memory,
+ * ERR_PTR(-EAGAIN) if the caller has to retry and ERR_PTR(-EFAULT) if the
+ * parent gmap table could not be protected.
+ */
+struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
+			 int edat_level)
+{
+	struct gmap *sg, *new;
+	unsigned long limit;
+	int rc;
+
+	if (KVM_BUG_ON(parent->mm->context.allow_gmap_hpage_1m, (struct kvm *)parent->private) ||
+	    KVM_BUG_ON(gmap_is_shadow(parent), (struct kvm *)parent->private))
+		return ERR_PTR(-EFAULT);
+	spin_lock(&parent->shadow_lock);
+	sg = gmap_find_shadow(parent, asce, edat_level);
+	spin_unlock(&parent->shadow_lock);
+	if (sg)
+		return sg;
+	/* Create a new shadow gmap */
+	limit = -1UL >> (33 - (((asce & _ASCE_TYPE_MASK) >> 2) * 11));
+	if (asce & _ASCE_REAL_SPACE)
+		limit = -1UL;
+	new = gmap_alloc(limit);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+	new->mm = parent->mm;
+	new->parent = gmap_get(parent);
+	new->private = parent->private;
+	new->orig_asce = asce;
+	new->edat_level = edat_level;
+	new->initialized = false;
+	spin_lock(&parent->shadow_lock);
+	/* Recheck if another CPU created the same shadow */
+	sg = gmap_find_shadow(parent, asce, edat_level);
+	if (sg) {
+		spin_unlock(&parent->shadow_lock);
+		gmap_free(new);
+		return sg;
+	}
+	if (asce & _ASCE_REAL_SPACE) {
+		/* only allow one real-space gmap shadow */
+		list_for_each_entry(sg, &parent->children, list) {
+			if (sg->orig_asce & _ASCE_REAL_SPACE) {
+				spin_lock(&sg->guest_table_lock);
+				gmap_unshadow(sg);
+				spin_unlock(&sg->guest_table_lock);
+				list_del(&sg->list);
+				gmap_put(sg);
+				break;
+			}
+		}
+	}
+	refcount_set(&new->ref_count, 2);
+	list_add(&new->list, &parent->children);
+	if (asce & _ASCE_REAL_SPACE) {
+		/* nothing to protect, return right away */
+		new->initialized = true;
+		spin_unlock(&parent->shadow_lock);
+		return new;
+	}
+	spin_unlock(&parent->shadow_lock);
+	/* protect after insertion, so it will get properly invalidated */
+	mmap_read_lock(parent->mm);
+	rc = __kvm_s390_mprotect_many(parent, asce & _ASCE_ORIGIN,
+				      ((asce & _ASCE_TABLE_LENGTH) + 1),
+				      PROT_READ, GMAP_NOTIFY_SHADOW);
+	mmap_read_unlock(parent->mm);
+	spin_lock(&parent->shadow_lock);
+	new->initialized = true;
+	if (rc) {
+		list_del(&new->list);
+		gmap_free(new);
+		new = ERR_PTR(rc);
+	}
+	spin_unlock(&parent->shadow_lock);
+	return new;
+}
diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index f2b52ce29be3..978f541059f0 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -13,5 +13,25 @@
 int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb);
 int gmap_convert_to_secure(struct gmap *gmap, unsigned long gaddr);
 int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr);
+struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce, int edat_level);
+
+/**
+ * gmap_shadow_valid - check if a shadow guest address space matches the
+ *                     given properties and is still valid
+ * @sg: pointer to the shadow guest address space structure
+ * @asce: ASCE for which the shadow table is requested
+ * @edat_level: edat level to be used for the shadow translation
+ *
+ * Returns 1 if the gmap shadow is still valid and matches the given
+ * properties, the caller can continue using it. Returns 0 otherwise, the
+ * caller has to request a new shadow gmap in this case.
+ *
+ */
+static inline int gmap_shadow_valid(struct gmap *sg, unsigned long asce, int edat_level)
+{
+	if (sg->removed)
+		return 0;
+	return sg->orig_asce == asce && sg->edat_level == edat_level;
+}
 
 #endif
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7608cffb805f..769d66cedbb7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4509,6 +4509,63 @@ static bool ibs_enabled(struct kvm_vcpu *vcpu)
 	return kvm_s390_test_cpuflags(vcpu, CPUSTAT_IBS);
 }
 
+static int __kvm_s390_fixup_fault_sync(struct gmap *gmap, gpa_t gaddr, unsigned int flags)
+{
+	struct kvm *kvm = gmap->private;
+	gfn_t gfn = gpa_to_gfn(gaddr);
+	bool unlocked;
+	hva_t vmaddr;
+	gpa_t tmp;
+	int rc;
+
+	if (kvm_is_ucontrol(kvm)) {
+		tmp = __gmap_translate(gmap, gaddr);
+		gfn = gpa_to_gfn(tmp);
+	}
+
+	vmaddr = gfn_to_hva(kvm, gfn);
+	rc = fixup_user_fault(gmap->mm, vmaddr, FAULT_FLAG_WRITE, &unlocked);
+	if (!rc)
+		rc = __gmap_link(gmap, gaddr, vmaddr);
+	return rc;
+}
+
+int __kvm_s390_mprotect_many(struct gmap *gmap, gpa_t gpa, u8 npages, unsigned int prot,
+			     unsigned long bits)
+{
+	unsigned int fault_flag = (prot & PROT_WRITE) ? FAULT_FLAG_WRITE : 0;
+	gpa_t end = gpa + npages * PAGE_SIZE;
+	int rc;
+
+	for (; gpa < end; gpa = ALIGN(gpa + 1, rc ? HPAGE_SIZE : PAGE_SIZE)) {
+		rc = gmap_protect_one(gmap, gpa, prot, bits);
+		if (rc == -EAGAIN) {
+			__kvm_s390_fixup_fault_sync(gmap, gpa, fault_flag);
+			rc = gmap_protect_one(gmap, gpa, prot, bits);
+		}
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int kvm_s390_mprotect_notify_prefix(struct kvm_vcpu *vcpu)
+{
+	gpa_t gaddr = kvm_s390_get_prefix(vcpu);
+	int idx, rc;
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+	mmap_read_lock(vcpu->arch.gmap->mm);
+
+	rc = __kvm_s390_mprotect_many(vcpu->arch.gmap, gaddr, 2, PROT_WRITE, GMAP_NOTIFY_MPROT);
+
+	mmap_read_unlock(vcpu->arch.gmap->mm);
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	return rc;
+}
+
 static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 {
 retry:
@@ -4524,9 +4581,8 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 	 */
 	if (kvm_check_request(KVM_REQ_REFRESH_GUEST_PREFIX, vcpu)) {
 		int rc;
-		rc = gmap_mprotect_notify(vcpu->arch.gmap,
-					  kvm_s390_get_prefix(vcpu),
-					  PAGE_SIZE * 2, PROT_WRITE);
+
+		rc = kvm_s390_mprotect_notify_prefix(vcpu);
 		if (rc) {
 			kvm_make_request(KVM_REQ_REFRESH_GUEST_PREFIX, vcpu);
 			return rc;
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 61e8544924b3..8d3bbb2dd8d2 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -420,6 +420,8 @@ void kvm_s390_set_cpu_timer(struct kvm_vcpu *vcpu, __u64 cputm);
 __u64 kvm_s390_get_cpu_timer(struct kvm_vcpu *vcpu);
 int kvm_s390_cpus_from_pv(struct kvm *kvm, u16 *rc, u16 *rrc);
 int __kvm_s390_handle_dat_fault(struct kvm_vcpu *vcpu, gfn_t gfn, gpa_t gaddr, unsigned int flags);
+int __kvm_s390_mprotect_many(struct gmap *gmap, gpa_t gpa, u8 npages, unsigned int prot,
+			     unsigned long bits);
 
 static inline int kvm_s390_handle_dat_fault(struct kvm_vcpu *vcpu, gpa_t gaddr, unsigned int flags)
 {
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index a687695d8f68..4fef3b38bd70 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -13,6 +13,7 @@
 #include <linux/bitmap.h>
 #include <linux/sched/signal.h>
 #include <linux/io.h>
+#include <linux/mman.h>
 
 #include <asm/gmap.h>
 #include <asm/mmu_context.h>
@@ -22,6 +23,7 @@
 #include <asm/facility.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
+#include "gmap.h"
 
 struct vsie_page {
 	struct kvm_s390_sie_block scb_s;	/* 0x0000 */
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index ae6ccf034378..12d681b657b4 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -43,7 +43,7 @@ static struct page *gmap_alloc_crst(void)
  *
  * Returns a guest address space structure.
  */
-static struct gmap *gmap_alloc(unsigned long limit)
+struct gmap *gmap_alloc(unsigned long limit)
 {
 	struct gmap *gmap;
 	struct page *page;
@@ -97,6 +97,7 @@ static struct gmap *gmap_alloc(unsigned long limit)
 out:
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(gmap_alloc);
 
 /**
  * gmap_create - create a guest address space
@@ -191,7 +192,7 @@ static void gmap_rmap_radix_tree_free(struct radix_tree_root *root)
  *
  * No locks required. There are no references to this gmap anymore.
  */
-static void gmap_free(struct gmap *gmap)
+void gmap_free(struct gmap *gmap)
 {
 	struct page *page, *next;
 
@@ -218,6 +219,7 @@ static void gmap_free(struct gmap *gmap)
 
 	kfree(gmap);
 }
+EXPORT_SYMBOL_GPL(gmap_free);
 
 /**
  * gmap_get - increase reference counter for guest address space
@@ -958,86 +960,36 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
  * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
  * @bits: pgste notification bits to set
  *
- * Returns 0 if successfully protected, -ENOMEM if out of memory and
- * -EFAULT if gaddr is invalid (or mapping for shadows is missing).
+ * Returns 0 if successfully protected, -ENOMEM if out of memory,
+ * -EFAULT if gaddr is invalid (or mapping for shadows is missing),
+ * -EAGAIN if the guest mapping is missing and should be fixed by the
+ * caller.
  *
  * Called with sg->mm->mmap_lock in read.
  */
-static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
-			      unsigned long len, int prot, unsigned long bits)
+int gmap_protect_one(struct gmap *gmap, unsigned long gaddr, int prot, unsigned long bits)
 {
-	unsigned long vmaddr, dist;
 	pmd_t *pmdp;
-	int rc;
+	int rc = 0;
 
 	BUG_ON(gmap_is_shadow(gmap));
-	while (len) {
-		rc = -EAGAIN;
-		pmdp = gmap_pmd_op_walk(gmap, gaddr);
-		if (pmdp) {
-			if (!pmd_leaf(*pmdp)) {
-				rc = gmap_protect_pte(gmap, gaddr, pmdp, prot,
-						      bits);
-				if (!rc) {
-					len -= PAGE_SIZE;
-					gaddr += PAGE_SIZE;
-				}
-			} else {
-				rc = gmap_protect_pmd(gmap, gaddr, pmdp, prot,
-						      bits);
-				if (!rc) {
-					dist = HPAGE_SIZE - (gaddr & ~HPAGE_MASK);
-					len = len < dist ? 0 : len - dist;
-					gaddr = (gaddr & HPAGE_MASK) + HPAGE_SIZE;
-				}
-			}
-			gmap_pmd_op_end(gmap, pmdp);
-		}
-		if (rc) {
-			if (rc == -EINVAL)
-				return rc;
 
-			/* -EAGAIN, fixup of userspace mm and gmap */
-			vmaddr = __gmap_translate(gmap, gaddr);
-			if (IS_ERR_VALUE(vmaddr))
-				return vmaddr;
-			rc = gmap_pte_op_fixup(gmap, gaddr, vmaddr, prot);
-			if (rc)
-				return rc;
-		}
-	}
-	return 0;
-}
+	pmdp = gmap_pmd_op_walk(gmap, gaddr);
+	if (!pmdp)
+		return -EAGAIN;
 
-/**
- * gmap_mprotect_notify - change access rights for a range of ptes and
- *                        call the notifier if any pte changes again
- * @gmap: pointer to guest mapping meta data structure
- * @gaddr: virtual address in the guest address space
- * @len: size of area
- * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE
- *
- * Returns 0 if for each page in the given range a gmap mapping exists,
- * the new access rights could be set and the notifier could be armed.
- * If the gmap mapping is missing for one or more pages -EFAULT is
- * returned. If no memory could be allocated -ENOMEM is returned.
- * This function establishes missing page table entries.
- */
-int gmap_mprotect_notify(struct gmap *gmap, unsigned long gaddr,
-			 unsigned long len, int prot)
-{
-	int rc;
+	if (!pmd_leaf(*pmdp)) {
+		rc = gmap_protect_pte(gmap, gaddr, pmdp, prot, bits);
+	} else {
+		rc = gmap_protect_pmd(gmap, gaddr, pmdp, prot, bits);
+		if (!rc)
+			rc = 1;
+	}
+	gmap_pmd_op_end(gmap, pmdp);
 
-	if ((gaddr & ~PAGE_MASK) || (len & ~PAGE_MASK) || gmap_is_shadow(gmap))
-		return -EINVAL;
-	if (!MACHINE_HAS_ESOP && prot == PROT_READ)
-		return -EINVAL;
-	mmap_read_lock(gmap->mm);
-	rc = gmap_protect_range(gmap, gaddr, len, prot, GMAP_NOTIFY_MPROT);
-	mmap_read_unlock(gmap->mm);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(gmap_mprotect_notify);
+EXPORT_SYMBOL_GPL(gmap_protect_one);
 
 /**
  * gmap_read_table - get an unsigned long value from a guest page table using
@@ -1488,7 +1440,7 @@ static void __gmap_unshadow_r1t(struct gmap *sg, unsigned long raddr,
  *
  * Called with sg->guest_table_lock
  */
-static void gmap_unshadow(struct gmap *sg)
+void gmap_unshadow(struct gmap *sg)
 {
 	unsigned long *table;
 
@@ -1514,143 +1466,7 @@ static void gmap_unshadow(struct gmap *sg)
 		break;
 	}
 }
-
-/**
- * gmap_find_shadow - find a specific asce in the list of shadow tables
- * @parent: pointer to the parent gmap
- * @asce: ASCE for which the shadow table is created
- * @edat_level: edat level to be used for the shadow translation
- *
- * Returns the pointer to a gmap if a shadow table with the given asce is
- * already available, ERR_PTR(-EAGAIN) if another one is just being created,
- * otherwise NULL
- */
-static struct gmap *gmap_find_shadow(struct gmap *parent, unsigned long asce,
-				     int edat_level)
-{
-	struct gmap *sg;
-
-	list_for_each_entry(sg, &parent->children, list) {
-		if (sg->orig_asce != asce || sg->edat_level != edat_level ||
-		    sg->removed)
-			continue;
-		if (!sg->initialized)
-			return ERR_PTR(-EAGAIN);
-		refcount_inc(&sg->ref_count);
-		return sg;
-	}
-	return NULL;
-}
-
-/**
- * gmap_shadow_valid - check if a shadow guest address space matches the
- *                     given properties and is still valid
- * @sg: pointer to the shadow guest address space structure
- * @asce: ASCE for which the shadow table is requested
- * @edat_level: edat level to be used for the shadow translation
- *
- * Returns 1 if the gmap shadow is still valid and matches the given
- * properties, the caller can continue using it. Returns 0 otherwise, the
- * caller has to request a new shadow gmap in this case.
- *
- */
-int gmap_shadow_valid(struct gmap *sg, unsigned long asce, int edat_level)
-{
-	if (sg->removed)
-		return 0;
-	return sg->orig_asce == asce && sg->edat_level == edat_level;
-}
-EXPORT_SYMBOL_GPL(gmap_shadow_valid);
-
-/**
- * gmap_shadow - create/find a shadow guest address space
- * @parent: pointer to the parent gmap
- * @asce: ASCE for which the shadow table is created
- * @edat_level: edat level to be used for the shadow translation
- *
- * The pages of the top level page table referred by the asce parameter
- * will be set to read-only and marked in the PGSTEs of the kvm process.
- * The shadow table will be removed automatically on any change to the
- * PTE mapping for the source table.
- *
- * Returns a guest address space structure, ERR_PTR(-ENOMEM) if out of memory,
- * ERR_PTR(-EAGAIN) if the caller has to retry and ERR_PTR(-EFAULT) if the
- * parent gmap table could not be protected.
- */
-struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
-			 int edat_level)
-{
-	struct gmap *sg, *new;
-	unsigned long limit;
-	int rc;
-
-	BUG_ON(parent->mm->context.allow_gmap_hpage_1m);
-	BUG_ON(gmap_is_shadow(parent));
-	spin_lock(&parent->shadow_lock);
-	sg = gmap_find_shadow(parent, asce, edat_level);
-	spin_unlock(&parent->shadow_lock);
-	if (sg)
-		return sg;
-	/* Create a new shadow gmap */
-	limit = -1UL >> (33 - (((asce & _ASCE_TYPE_MASK) >> 2) * 11));
-	if (asce & _ASCE_REAL_SPACE)
-		limit = -1UL;
-	new = gmap_alloc(limit);
-	if (!new)
-		return ERR_PTR(-ENOMEM);
-	new->mm = parent->mm;
-	new->parent = gmap_get(parent);
-	new->private = parent->private;
-	new->orig_asce = asce;
-	new->edat_level = edat_level;
-	new->initialized = false;
-	spin_lock(&parent->shadow_lock);
-	/* Recheck if another CPU created the same shadow */
-	sg = gmap_find_shadow(parent, asce, edat_level);
-	if (sg) {
-		spin_unlock(&parent->shadow_lock);
-		gmap_free(new);
-		return sg;
-	}
-	if (asce & _ASCE_REAL_SPACE) {
-		/* only allow one real-space gmap shadow */
-		list_for_each_entry(sg, &parent->children, list) {
-			if (sg->orig_asce & _ASCE_REAL_SPACE) {
-				spin_lock(&sg->guest_table_lock);
-				gmap_unshadow(sg);
-				spin_unlock(&sg->guest_table_lock);
-				list_del(&sg->list);
-				gmap_put(sg);
-				break;
-			}
-		}
-	}
-	refcount_set(&new->ref_count, 2);
-	list_add(&new->list, &parent->children);
-	if (asce & _ASCE_REAL_SPACE) {
-		/* nothing to protect, return right away */
-		new->initialized = true;
-		spin_unlock(&parent->shadow_lock);
-		return new;
-	}
-	spin_unlock(&parent->shadow_lock);
-	/* protect after insertion, so it will get properly invalidated */
-	mmap_read_lock(parent->mm);
-	rc = gmap_protect_range(parent, asce & _ASCE_ORIGIN,
-				((asce & _ASCE_TABLE_LENGTH) + 1) * PAGE_SIZE,
-				PROT_READ, GMAP_NOTIFY_SHADOW);
-	mmap_read_unlock(parent->mm);
-	spin_lock(&parent->shadow_lock);
-	new->initialized = true;
-	if (rc) {
-		list_del(&new->list);
-		gmap_free(new);
-		new = ERR_PTR(rc);
-	}
-	spin_unlock(&parent->shadow_lock);
-	return new;
-}
-EXPORT_SYMBOL_GPL(gmap_shadow);
+EXPORT_SYMBOL(gmap_unshadow);
 
 /**
  * gmap_shadow_r2t - create an empty shadow region 2 table
-- 
2.47.1


