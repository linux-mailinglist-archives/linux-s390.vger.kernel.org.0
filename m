Return-Path: <linux-s390+bounces-25-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABC67F36DC
	for <lists+linux-s390@lfdr.de>; Tue, 21 Nov 2023 20:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F0A1C20C0A
	for <lists+linux-s390@lfdr.de>; Tue, 21 Nov 2023 19:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A6E42041;
	Tue, 21 Nov 2023 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ew37sGr7"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF3D18E;
	Tue, 21 Nov 2023 11:44:01 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALJV7hk016863;
	Tue, 21 Nov 2023 19:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=sfoseUW6X0FYp/4SUVJyXVhMgfGyNvGbGq8xzf/X2+k=;
 b=ew37sGr72F7mpnAQzXl3m9nhFJV0DFJ5qk6WKw80Et7ZbgRSv2ry3q/svksvxGNTmRM7
 8Fd6ItVp3Q9OLquYsNhz2PDj8typQctLcYUliMr3wq6wDNhVZA4CCRF/0MYlY5Zt81YG
 pah/xmUZE6Er2HvsDIPgdpUN/WH2j4UFaQlHdPUOw0SRNBEsuRoh+amMQRitnBgf/khZ
 Rlh+DZKD67qOkCljedD4dDZv+wXqSUHzmV5Lio43d4L+XAo6mB+Lsb1CN+t7uu6XPeJ0
 +D+CLvyHsjZZT5ChbXEtuz1q+MN+fl9BAwfG1F6zpBmQKQ5uaPSzsAF3nBgq+V6EnR1o aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh2gc0jgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 19:43:56 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALJVJO7017714;
	Tue, 21 Nov 2023 19:43:56 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh2gc0jfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 19:43:55 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALIZQM1005833;
	Tue, 21 Nov 2023 19:43:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yyk70g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 19:43:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALJhpCF10682918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 19:43:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 599C920049;
	Tue, 21 Nov 2023 19:43:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4825020040;
	Tue, 21 Nov 2023 19:43:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Nov 2023 19:43:51 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id E9492E15BD; Tue, 21 Nov 2023 20:43:50 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Vishal Moola <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v3 2/2] pgtable: rename ptdesc _refcount field to __page_refcount
Date: Tue, 21 Nov 2023 20:43:50 +0100
Message-Id: <982bdc652ba79a606c3d01c905766e7e076b3315.1700594815.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1700594815.git.agordeev@linux.ibm.com>
References: <cover.1700594815.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ak6U_akwJ3mCn-SzIoTVHRALtQuL-Vg2
X-Proofpoint-GUID: I7mM7rYEn9TiBvsCbfyTHufWwX4Zelle
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210153

Rename ptdesc _refcount field to __page_refcount similar
to the other unused page fields.

Suggested-by: Vishal Moola <vishal.moola@gmail.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 include/linux/mm_types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index fbec64036baa..ef18d2b25378 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -405,7 +405,7 @@ FOLIO_MATCH(compound_head, _head_2a);
  * @_pt_pad_2:        Padding to ensure proper alignment.
  * @ptl:              Lock for the page table.
  * @__page_type:      Same as page->page_type. Unused for page tables.
- * @_refcount:        Same as page refcount.
+ * @__page_refcount:  Same as page refcount.
  * @pt_memcg_data:    Memcg data. Tracked for page tables here.
  *
  * This struct overlays struct page for now. Do not modify without a good
@@ -438,7 +438,7 @@ struct ptdesc {
 #endif
 	};
 	unsigned int __page_type;
-	atomic_t _refcount;
+	atomic_t __page_refcount;
 #ifdef CONFIG_MEMCG
 	unsigned long pt_memcg_data;
 #endif
@@ -452,7 +452,7 @@ TABLE_MATCH(compound_head, _pt_pad_1);
 TABLE_MATCH(mapping, __page_mapping);
 TABLE_MATCH(rcu_head, pt_rcu_head);
 TABLE_MATCH(page_type, __page_type);
-TABLE_MATCH(_refcount, _refcount);
+TABLE_MATCH(_refcount, __page_refcount);
 #ifdef CONFIG_MEMCG
 TABLE_MATCH(memcg_data, pt_memcg_data);
 #endif
-- 
2.39.2


