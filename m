Return-Path: <linux-s390+bounces-26-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C847F36DD
	for <lists+linux-s390@lfdr.de>; Tue, 21 Nov 2023 20:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A082282A5C
	for <lists+linux-s390@lfdr.de>; Tue, 21 Nov 2023 19:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF0242042;
	Tue, 21 Nov 2023 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sEQ85I7i"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A6C197;
	Tue, 21 Nov 2023 11:44:01 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALJV6Tx016765;
	Tue, 21 Nov 2023 19:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0qCTPnVf7eW8u068diNRbrmHzRxDoghcf3d2UPQTSCo=;
 b=sEQ85I7iHJ4evsoJRr53L6MD2AqiTLozPRaOiCYmF7Plvzdh+renI8DnuuW+Wt0++1cx
 ve8TUkrGSmY8+TgiS5rUbfG3IR5hrP7kgUNLHeXlh68F6N2RTG4KZMX4PiuzuA4fY/03
 hvOG/po0ZC16utXwaKccT95OQ/XCfDX4sMsw6Hf8EJ2m+mpbvzV/tl4R4X269sO93VBr
 tWy0/TmJQamcojqYVAflvTTO4CrEGumjH4Xu3o7VR5UfUno6NYvF/Y7Cnctch4IY5+Wn
 qtZTctUrLn2dUITKrxxg5Wnd5RTzM0JOvJzBzMBD5pP94pDWmzkynIfGp57I7FMPM39a uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh2gc0jgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 19:43:56 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALJXYK3023494;
	Tue, 21 Nov 2023 19:43:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh2gc0jfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 19:43:55 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALIVBLB010303;
	Tue, 21 Nov 2023 19:43:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93ktw50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 19:43:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALJhpZO66257214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 19:43:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46BA920043;
	Tue, 21 Nov 2023 19:43:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3768820040;
	Tue, 21 Nov 2023 19:43:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Nov 2023 19:43:51 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id E50A4E0320; Tue, 21 Nov 2023 20:43:50 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Vishal Moola <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v3 0/2] minor ptdesc updates
Date: Tue, 21 Nov 2023 20:43:48 +0100
Message-Id: <cover.1700594815.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Us9EXl4cpIv4nauzzRT8v61RerjCObOH
X-Proofpoint-GUID: OzaNylK7WK_VF-uJDwJAFuWaeme9FxMO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 spamscore=0 mlxlogscore=678 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210153

Hi Vishal, Andrew,

Please find v3 of s390-caused ptdesc updates.

Changes since v2:
- single patch split in two;
- _refcount renamed to __page_refcount;
- _refcount TABLE_MATCH() check restored;

Changes since v1:
- missing comment to _pt_pad_3 padding added;

Thanks!

Alexander Gordeev (2):
  pgtable: fix s390 ptdesc field comments
  pgtable: rename ptdesc _refcount field to __page_refcount

 include/linux/mm_types.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.39.2


