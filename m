Return-Path: <linux-s390+bounces-185-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC8D7F9B95
	for <lists+linux-s390@lfdr.de>; Mon, 27 Nov 2023 09:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D00280D4F
	for <lists+linux-s390@lfdr.de>; Mon, 27 Nov 2023 08:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F2610785;
	Mon, 27 Nov 2023 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bEba76+w"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1221F181;
	Mon, 27 Nov 2023 00:20:42 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR6dFDh010309;
	Mon, 27 Nov 2023 08:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VVtBHAgbLKbJwKCdTkswyGCbNkhwPlVjeKakadfoyQQ=;
 b=bEba76+wkHM8HXSWFmi2BaU8x+88bBaILVm8Aup3+DpGnp5dlvofkDIrP/w8jaMb0jdF
 JfX3zJ1w1CFI37iSaflhyy49ptMV7dGW3UFRYQTHrlADSSUxwVUGM2eNluwoCWeTHTyE
 TVtTT2XoObeYq5XuIl4aAAN0vM33E/wbbE+bVkrL2K+Whll/vTA+Txxq8Z8IRevvHYDQ
 9LsHNp3HxQqFLzXygUuvbheityJee6PagHiTiKdqiI6DNGhtRA8iTk4sX+Q7NVc5pWst
 C3unX1ttbh3Ew5tfA2L883Npo2/dHAbrNmdVj0dharblDLt6YODCckbzrtkIYt/lJ+dD lA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umjn5enkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 08:20:31 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AR6vwMc000756;
	Mon, 27 Nov 2023 08:20:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umjn5enk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 08:20:30 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR8JQhe024798;
	Mon, 27 Nov 2023 08:20:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfjpwxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Nov 2023 08:20:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AR8KRTR21299782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 08:20:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0912C20040;
	Mon, 27 Nov 2023 08:20:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98BC720043;
	Mon, 27 Nov 2023 08:20:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Nov 2023 08:20:26 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/5] s390/sclp: remove unhandled memory notifier type
Date: Mon, 27 Nov 2023 09:20:21 +0100
Message-Id: <20231127082023.2079810-4-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127082023.2079810-1-sumanthk@linux.ibm.com>
References: <20231127082023.2079810-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5EEkk_6-SZhQagXPc5J04qBLLTBx-fkn
X-Proofpoint-ORIG-GUID: VdcHQxy_svZgW537ilhlK5PSyE2yKod9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_06,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=732 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311270057

Remove memory notifier types which are unhandled by s390.  Unhandled
memory notifier types are covered by default case.

Suggested-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/s390/char/sclp_cmd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index 11c428f4c7cf..355e63e44e95 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -340,9 +340,6 @@ static int sclp_mem_notifier(struct notifier_block *nb,
 		if (contains_standby_increment(start, start + size))
 			rc = -EPERM;
 		break;
-	case MEM_ONLINE:
-	case MEM_CANCEL_OFFLINE:
-		break;
 	case MEM_GOING_ONLINE:
 		rc = sclp_mem_change_state(start, size, 1);
 		break;
-- 
2.41.0


