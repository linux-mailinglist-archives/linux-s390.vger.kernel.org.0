Return-Path: <linux-s390+bounces-8589-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A1A1A5FD
	for <lists+linux-s390@lfdr.de>; Thu, 23 Jan 2025 15:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FD8169839
	for <lists+linux-s390@lfdr.de>; Thu, 23 Jan 2025 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277F021322E;
	Thu, 23 Jan 2025 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="noc/MsQq"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD9212FBF;
	Thu, 23 Jan 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737643605; cv=none; b=st+6lsnduxWrTFYZX6U/AjNozVQSOZOTY7F59GroM2HMRlKdEq+pJia9aAYymb1atIW/mCuXofRgt0G/QC+jHtWw4BYsFpEpHJo2VGHxY54IoN/tp3142ZuPSTgDhe0hnEAJHOUdLdIzH73KTXEECXf04dwZ5VLtZ4vjmNa4oro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737643605; c=relaxed/simple;
	bh=58hwVVaELyYBdhUWsTnse1kmiGCOYU9Vf9wu/RHauTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwSqwjyrwAIRhndF+CY6tL4JtlKa1sx9QtnXnZzdhUg789M+u9SQNbbOPqejkm9AnvcM2+Lo4GBtLxupEXF6avdvs1l5R83i8Ar+YSbnYOQRfKMGeHc3QXG4/6AX/m65jHrTQ1AurtH3lKAXIUNjvs7M6c32Va14hM5QzUlKTOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=noc/MsQq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NBcq4H027577;
	Thu, 23 Jan 2025 14:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ExzggXOBv7+v/gDuO
	wbpZaE1mz1o+4GdLRZmaBcm1qQ=; b=noc/MsQqd+6YycPboOzjYVaOhP/PmeNEg
	ylvhHf3Y4aOjlfpthN5Nm5Yxk8fVRIZYa0x+Uf8YXt7etnK7dulVLZA/PDRftVF+
	VVj4g9m6TZ3edhMPpMcEyHllszChrTBYW8hHCknELbmOoTq/xbl9ku+dH/XbizwX
	qBMUFHVFKEGReeLwQgEwLh9pmufkLpjdTxMnmR8jsbq2QwYVAoQidSw1b8oh/cva
	CxtW0U2HyOBWLIRlBKhwxcFKa00Yw8FhaKDPtHYEeMDq8hFVpLsa/5RW2aNZNgRz
	RtXZQhIphmZ/lrEKzt8ptPoZ6RBfoyGf8lUCUoRhv2GXXpt5dY05w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44b2xyp49w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 14:46:38 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50NEgRcl024572;
	Thu, 23 Jan 2025 14:46:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44b2xyp49r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 14:46:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NESVEK024225;
	Thu, 23 Jan 2025 14:46:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0ye3r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 14:46:36 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NEkW8750463090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 14:46:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B447620040;
	Thu, 23 Jan 2025 14:46:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EE0A20043;
	Thu, 23 Jan 2025 14:46:32 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 14:46:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, borntraeger@de.ibm.com,
        schlameuss@linux.ibm.com, david@redhat.com, willy@infradead.org,
        hca@linux.ibm.com, svens@linux.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com, nrb@linux.ibm.com, nsg@linux.ibm.com,
        seanjc@google.com, seiden@linux.ibm.com, pbonzini@redhat.com
Subject: [PATCH v4 15/15] KVM: s390: remove the last user of page->index
Date: Thu, 23 Jan 2025 15:46:27 +0100
Message-ID: <20250123144627.312456-16-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123144627.312456-1-imbrenda@linux.ibm.com>
References: <20250123144627.312456-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jxMqq8jcFNfyPEXDZwd0Zoybb_JV0Rj9
X-Proofpoint-ORIG-GUID: jMAIiwleg2kF4ntMNm5440QFZZq5FVP0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501230108

Shadow page tables use page->index to keep the g2 address of the guest
page table being shadowed.

Instead of keeping the information in page->index, split the address
and smear it over the 16-bit softbits areas of 4 PGSTEs.

This removes the last s390 user of page->index.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 15 +++++++++++++++
 arch/s390/kvm/gaccess.c         |  6 ++++--
 arch/s390/mm/gmap.c             | 22 ++++++++++++++++++++--
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 151488bb9ed7..7d771b0b6bb4 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -419,6 +419,7 @@ static inline int is_module_addr(void *addr)
 #define PGSTE_HC_BIT	0x0020000000000000UL
 #define PGSTE_GR_BIT	0x0004000000000000UL
 #define PGSTE_GC_BIT	0x0002000000000000UL
+#define PGSTE_ST2_MASK	0x0000ffff00000000UL
 #define PGSTE_UC_BIT	0x0000000000008000UL	/* user dirty (migration) */
 #define PGSTE_IN_BIT	0x0000000000004000UL	/* IPTE notify bit */
 #define PGSTE_VSIE_BIT	0x0000000000002000UL	/* ref'd in a shadow table */
@@ -2001,4 +2002,18 @@ extern void s390_reset_cmma(struct mm_struct *mm);
 #define pmd_pgtable(pmd) \
 	((pgtable_t)__va(pmd_val(pmd) & -sizeof(pte_t)*PTRS_PER_PTE))
 
+static inline unsigned long gmap_pgste_get_pgt_addr(unsigned long *pgt)
+{
+	unsigned long *pgstes, res;
+
+	pgstes = pgt + _PAGE_ENTRIES;
+
+	res = (pgstes[0] & PGSTE_ST2_MASK) << 16;
+	res |= pgstes[1] & PGSTE_ST2_MASK;
+	res |= (pgstes[2] & PGSTE_ST2_MASK) >> 16;
+	res |= (pgstes[3] & PGSTE_ST2_MASK) >> 32;
+
+	return res;
+}
+
 #endif /* _S390_PAGE_H */
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index bb1340389369..f6fded15633a 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1409,6 +1409,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 static int shadow_pgt_lookup(struct gmap *sg, unsigned long saddr, unsigned long *pgt,
 			     int *dat_protection, int *fake)
 {
+	unsigned long pt_index;
 	unsigned long *table;
 	struct page *page;
 	int rc;
@@ -1418,9 +1419,10 @@ static int shadow_pgt_lookup(struct gmap *sg, unsigned long saddr, unsigned long
 	if (table && !(*table & _SEGMENT_ENTRY_INVALID)) {
 		/* Shadow page tables are full pages (pte+pgste) */
 		page = pfn_to_page(*table >> PAGE_SHIFT);
-		*pgt = page->index & ~GMAP_SHADOW_FAKE_TABLE;
+		pt_index = gmap_pgste_get_pgt_addr(page_to_virt(page));
+		*pgt = pt_index & ~GMAP_SHADOW_FAKE_TABLE;
 		*dat_protection = !!(*table & _SEGMENT_ENTRY_PROTECT);
-		*fake = !!(page->index & GMAP_SHADOW_FAKE_TABLE);
+		*fake = !!(pt_index & GMAP_SHADOW_FAKE_TABLE);
 		rc = 0;
 	} else  {
 		rc = -EAGAIN;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 38f044321704..94d927785800 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1733,6 +1733,23 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 }
 EXPORT_SYMBOL_GPL(gmap_shadow_sgt);
 
+static void gmap_pgste_set_pgt_addr(struct ptdesc *ptdesc, unsigned long pgt_addr)
+{
+	unsigned long *pgstes = page_to_virt(ptdesc_page(ptdesc));
+
+	pgstes += _PAGE_ENTRIES;
+
+	pgstes[0] &= ~PGSTE_ST2_MASK;
+	pgstes[1] &= ~PGSTE_ST2_MASK;
+	pgstes[2] &= ~PGSTE_ST2_MASK;
+	pgstes[3] &= ~PGSTE_ST2_MASK;
+
+	pgstes[0] |= (pgt_addr >> 16) & PGSTE_ST2_MASK;
+	pgstes[1] |= pgt_addr & PGSTE_ST2_MASK;
+	pgstes[2] |= (pgt_addr << 16) & PGSTE_ST2_MASK;
+	pgstes[3] |= (pgt_addr << 32) & PGSTE_ST2_MASK;
+}
+
 /**
  * gmap_shadow_pgt - instantiate a shadow page table
  * @sg: pointer to the shadow guest address space structure
@@ -1760,9 +1777,10 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	ptdesc = page_table_alloc_pgste(sg->mm);
 	if (!ptdesc)
 		return -ENOMEM;
-	ptdesc->pt_index = pgt & _SEGMENT_ENTRY_ORIGIN;
+	origin = pgt & _SEGMENT_ENTRY_ORIGIN;
 	if (fake)
-		ptdesc->pt_index |= GMAP_SHADOW_FAKE_TABLE;
+		origin |= GMAP_SHADOW_FAKE_TABLE;
+	gmap_pgste_set_pgt_addr(ptdesc, origin);
 	s_pgt = page_to_phys(ptdesc_page(ptdesc));
 	/* Install shadow page table */
 	spin_lock(&sg->guest_table_lock);
-- 
2.48.1


