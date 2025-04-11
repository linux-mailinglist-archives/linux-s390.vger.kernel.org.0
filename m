Return-Path: <linux-s390+bounces-9984-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A39A8670B
	for <lists+linux-s390@lfdr.de>; Fri, 11 Apr 2025 22:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7DC7B8532
	for <lists+linux-s390@lfdr.de>; Fri, 11 Apr 2025 20:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67DE290093;
	Fri, 11 Apr 2025 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DqPunv95"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1CA28CF4A;
	Fri, 11 Apr 2025 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403097; cv=none; b=sWi0ysdBsA198+XUTzlcSFkaKfemlMkahfLcwfz1i2olYd7p/U2yS0UBUdGjwV6WI1V02TlvJMBKJdPVgtVPkuveSCIaBWUzHeSEccMf0+SeubP6e0/GtZiiJfn11PNO4bnoGOQerVgcFEJCf8ZVcOzGMJpnyDxlUVJXQVOBhE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403097; c=relaxed/simple;
	bh=2qKsH5kv0ncdsyHod9k9bno1V2Ucw112xluXhuZPimk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ci9HSbxXSTsnJGuihAgdJtJdQldlC7xX6fpJCd9fJBK8bcxsBVBS5GkHkFk5d1tTDbx4wlpCfgrJGzVi2sflP/vZhTsJCR3cgzwkVs5O1rFRLAqp5eyn6Ebf7oGeM+8lA8rZq33u7C5pOXKesZnRJWfSFz/h8kQQn3A2lgEoG10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DqPunv95; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BIIP15023248;
	Fri, 11 Apr 2025 20:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=c39HqofJWxJJ4EWgu
	mfYfcuMArfFUHDA2BWbZqfDm44=; b=DqPunv95vZ3MStf2SfiShgbwNasmMZ2lZ
	T4kNCjobDwmxJ/qxFXgc2Ud4pD89wdUZVMavaso9SjGnw3I/abzHf5u9hnGonc9U
	qBRUFGoO5B0NNcTim/+IYNMnfqFb4c1HUJJH8bUpfhtrb8Djc1K0MrLELdixczbV
	Rggk4M/bc4ECxXJxI1J/z1CtRbtZb7iz3hyzR7jf2vMyWy77FIhJmGQxfX4D2E0s
	OL6x0l1dsprcrFZiENUctjM+4WK54zHEZoZsk99JuS7/nXzTHACx0OLDVddJ0O1m
	7fOFU6sqbYRtmWhVDMINmsKEPZnu4pZs+LEdEq2rLUt3qBQfetkaQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45y343tb6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 20:24:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BJsN3l029592;
	Fri, 11 Apr 2025 20:24:39 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45x1k7ajsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 20:24:39 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BKOb4p63242600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 20:24:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E79B58051;
	Fri, 11 Apr 2025 20:24:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 174A15805C;
	Fri, 11 Apr 2025 20:24:36 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.105.190])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 20:24:36 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v5 2/5] iommu/s390: support cleanup of additional table regions
Date: Fri, 11 Apr 2025 16:24:30 -0400
Message-ID: <20250411202433.181683-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411202433.181683-1-mjrosato@linux.ibm.com>
References: <20250411202433.181683-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QpkBOdDKAG2umgOUiB-xaSBCz0M5atXL
X-Proofpoint-ORIG-GUID: QpkBOdDKAG2umgOUiB-xaSBCz0M5atXL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=970
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110127

Extend the existing dma_cleanup_tables to also handle region second and
region first tables.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 71 ++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index cad032d4c9a6..f2cda0ce0fe9 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -121,6 +121,22 @@ static inline int pt_entry_isvalid(unsigned long entry)
 	return (entry & ZPCI_PTE_VALID_MASK) == ZPCI_PTE_VALID;
 }
 
+static inline unsigned long *get_rf_rso(unsigned long entry)
+{
+	if ((entry & ZPCI_TABLE_TYPE_MASK) == ZPCI_TABLE_TYPE_RFX)
+		return phys_to_virt(entry & ZPCI_RTE_ADDR_MASK);
+	else
+		return NULL;
+}
+
+static inline unsigned long *get_rs_rto(unsigned long entry)
+{
+	if ((entry & ZPCI_TABLE_TYPE_MASK) == ZPCI_TABLE_TYPE_RSX)
+		return phys_to_virt(entry & ZPCI_RTE_ADDR_MASK);
+	else
+		return NULL;
+}
+
 static inline unsigned long *get_rt_sto(unsigned long entry)
 {
 	if ((entry & ZPCI_TABLE_TYPE_MASK) == ZPCI_TABLE_TYPE_RTX)
@@ -192,18 +208,59 @@ static void dma_free_seg_table(unsigned long entry)
 	dma_free_cpu_table(sto);
 }
 
-static void dma_cleanup_tables(unsigned long *table)
+static void dma_free_rt_table(unsigned long entry)
 {
+	unsigned long *rto = get_rs_rto(entry);
 	int rtx;
 
-	if (!table)
+	for (rtx = 0; rtx < ZPCI_TABLE_ENTRIES; rtx++)
+		if (reg_entry_isvalid(rto[rtx]))
+			dma_free_seg_table(rto[rtx]);
+
+	dma_free_cpu_table(rto);
+}
+
+static void dma_free_rs_table(unsigned long entry)
+{
+	unsigned long *rso = get_rf_rso(entry);
+	int rsx;
+
+	for (rsx = 0; rsx < ZPCI_TABLE_ENTRIES; rsx++)
+		if (reg_entry_isvalid(rso[rsx]))
+			dma_free_rt_table(rso[rsx]);
+
+	dma_free_cpu_table(rso);
+}
+
+static void dma_cleanup_tables(struct s390_domain *domain)
+{
+	int rtx, rsx, rfx;
+
+	if (!domain->dma_table)
 		return;
 
-	for (rtx = 0; rtx < ZPCI_TABLE_ENTRIES; rtx++)
-		if (reg_entry_isvalid(table[rtx]))
-			dma_free_seg_table(table[rtx]);
+	switch (domain->origin_type) {
+	case ZPCI_TABLE_TYPE_RFX:
+		for (rfx = 0; rfx < ZPCI_TABLE_ENTRIES; rfx++)
+			if (reg_entry_isvalid(domain->dma_table[rfx]))
+				dma_free_rs_table(domain->dma_table[rfx]);
+		break;
+	case ZPCI_TABLE_TYPE_RSX:
+		for (rsx = 0; rsx < ZPCI_TABLE_ENTRIES; rsx++)
+			if (reg_entry_isvalid(domain->dma_table[rsx]))
+				dma_free_rt_table(domain->dma_table[rsx]);
+		break;
+	case ZPCI_TABLE_TYPE_RTX:
+		for (rtx = 0; rtx < ZPCI_TABLE_ENTRIES; rtx++)
+			if (reg_entry_isvalid(domain->dma_table[rtx]))
+				dma_free_seg_table(domain->dma_table[rtx]);
+		break;
+	default:
+		WARN_ONCE(1, "Invalid IOMMU table (%x)\n", domain->origin_type);
+		return;
+	}
 
-	dma_free_cpu_table(table);
+	dma_free_cpu_table(domain->dma_table);
 }
 
 static unsigned long *dma_alloc_page_table(gfp_t gfp)
@@ -358,7 +415,7 @@ static void s390_iommu_rcu_free_domain(struct rcu_head *head)
 {
 	struct s390_domain *s390_domain = container_of(head, struct s390_domain, rcu);
 
-	dma_cleanup_tables(s390_domain->dma_table);
+	dma_cleanup_tables(s390_domain);
 	kfree(s390_domain);
 }
 
-- 
2.49.0


