Return-Path: <linux-s390+bounces-567-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8348122FF
	for <lists+linux-s390@lfdr.de>; Thu, 14 Dec 2023 00:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E421F2110B
	for <lists+linux-s390@lfdr.de>; Wed, 13 Dec 2023 23:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5EF259D;
	Wed, 13 Dec 2023 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a/H46swg"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4AAE3;
	Wed, 13 Dec 2023 15:36:49 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDKaLvr003754;
	Wed, 13 Dec 2023 23:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+JRbg3kPizc/tKO6MSNyeUjOi3r5ENUit3Ra9toPyEk=;
 b=a/H46swgQVoQJZy7TsbXl7UvL7/fJ5cvph7WQ/+Iu0P3yxpByVz5l4lm2BST54peKoyF
 c/cLiYwJv7/wv4W4cVj5NQj3GeAs20M8LfFBLZ45kAUFnXWX3TMHXX2ZHvP71bNg/ndl
 dDVnTFouAA/9wvUHMfxjJwa4kxSH/mymbzr+51Qa0TVUad2O+XreWelrI50E8pOa4bE6
 qry0r5zWMlD/5wM/UCwIRVaKg0W2ukAotdoW+XoQbs//O/YS2sBXkvorlMJqF49eD5FH
 I1Ow08Yu+bWcJ4BTwxA38ceI79HYt/bJyy/+TCS5pB93o9czuty8nBkT0bOJRR54Rclz RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uykek48y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 23:36:24 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDNQT09028957;
	Wed, 13 Dec 2023 23:36:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uykek48xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 23:36:23 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDL4sCB028206;
	Wed, 13 Dec 2023 23:36:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw2xyvrnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 23:36:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BDNaJNT16188036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 23:36:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46D0F20043;
	Wed, 13 Dec 2023 23:36:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4A3220040;
	Wed, 13 Dec 2023 23:36:17 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.70.156])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Dec 2023 23:36:17 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 06/34] kmsan: Fix kmsan_copy_to_user() on arches with overlapping address spaces
Date: Thu, 14 Dec 2023 00:24:26 +0100
Message-ID: <20231213233605.661251-7-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213233605.661251-1-iii@linux.ibm.com>
References: <20231213233605.661251-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NvNFv9kzwaXyDaiNbiRkqnwnGpAGbYvC
X-Proofpoint-ORIG-GUID: 36qScC5OQSchjdmhk5MojrGx989GqACk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_14,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=748 suspectscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130167

Comparing pointers with TASK_SIZE does not make sense when kernel and
userspace overlap. Assume that we are handling user memory access in
this case.

Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/kmsan/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 5d6e2dee5692..eafc45f937eb 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -267,7 +267,8 @@ void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
 		return;
 
 	ua_flags = user_access_save();
-	if ((u64)to < TASK_SIZE) {
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) ||
+	    (u64)to < TASK_SIZE) {
 		/* This is a user memory access, check it. */
 		kmsan_internal_check_memory((void *)from, to_copy - left, to,
 					    REASON_COPY_TO_USER);
-- 
2.43.0


