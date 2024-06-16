Return-Path: <linux-s390+bounces-4355-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398BB909B0E
	for <lists+linux-s390@lfdr.de>; Sun, 16 Jun 2024 03:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392C81C20BD9
	for <lists+linux-s390@lfdr.de>; Sun, 16 Jun 2024 01:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5C0154C0E;
	Sun, 16 Jun 2024 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dzNv++bX"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCEB2E403;
	Sun, 16 Jun 2024 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718501009; cv=none; b=dxKmo1XkAZLISKwILbPbASy/eXuKEGelNWKvM5yI2iTP9403Mga3XFaMy+gt5l3n/hrXtTsGREDAQ9HZjJ38jlU2L+9NYgUdiOar5AyJb9/UssuUcf1PC+NitklByUNsmMzEJyX/U3CacfXmjJZ/KgXycUbSAd3Nvkz3474K58Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718501009; c=relaxed/simple;
	bh=VvyT3rRkET4hnFgBAFEwQnLwekfT0zcexKkGgHZ9wcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=OGvOwEFk6/PudAGCbngBkianSsN1CgCjtsl7Af9i5z0VtOkoLMpoT6i3IBvcc5CpK8IMXVxnysBxnce2Pv9IQs1v6NMQXz882KiStaeHXZKr4m898OrhDLjJDS19IeYjNfrGf/b8fjtIPV/DCYJN66jjQk45JRjdgVLgjmwPLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dzNv++bX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45G05jTt019170;
	Sun, 16 Jun 2024 01:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Kvrhe4tiwKNstnmbSAG2zL
	OZuyz9v+p7yugfSwm/0NQ=; b=dzNv++bXB+oiQh6rxuBLzbh6XBso3JkDintPQK
	ZucDYZva1yXU5kLH/6Fs47ErkE+8iDsDSPLH1c6smFZU4qv43L9za/V0z6pGwNMh
	UFe9JYtq67H9Xd7XRPO37iAQp2eV2LAVNsU5fUB0kImCbKgewFFZRyesZdbLooeL
	KGkFk8779VvHaEGRWtQKaRnb5SX9kH2oDaOAOjjoaKFTafB38YsLF7V/ZhlRSXKs
	ccmuCKNwScrTn/WF81hOdIAIfJT5TnDjILV1D5Gw/5jHHReEYflnb9rDAm+W6NYO
	XNzTprEAQAPjRzjUIH1BkebdQqPnu4l53GqA9mm3lsnvuKqQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys0an1fk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 01:23:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45G1NO8I027402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 01:23:24 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 15 Jun
 2024 18:23:23 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 15 Jun 2024 18:23:21 -0700
Subject: [PATCH] s390/mm: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240615-md-s390-arch-s390-mm-v1-1-a360eed8c7c3@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIg+bmYC/yXMQQrCMBCF4auUWTuQtFXUq4iLNDMxAybKTJVC6
 d2Nunvf4v0rGKuwwblbQfktJo/a4HcdxBzqjVGoGXrXj+7g91gIbTg5DBrzf5WC4zEReeLkBoJ
 2fSonWX7Zy7V5CsY4aagxf2N3qa8FS7CZFbbtA/9Ekp+FAAAA
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "Vasily
 Gorbik" <gor@linux.ibm.com>,
        Christian Borntraeger
	<borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
CC: <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6VqzuNPI-f11LbPXLSYKWQDdcu1aLOrH
X-Proofpoint-ORIG-GUID: 6VqzuNPI-f11LbPXLSYKWQDdcu1aLOrH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-15_18,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=752
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406160009

With ARCH=s390, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/s390/mm/cmm.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 arch/s390/mm/cmm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index f8b13f247646..5cb5e724cde3 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -427,4 +427,5 @@ static void __exit cmm_exit(void)
 }
 module_exit(cmm_exit);
 
+MODULE_DESCRIPTION("Cooperative memory management interface");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240615-md-s390-arch-s390-mm-48fdd1def03d


