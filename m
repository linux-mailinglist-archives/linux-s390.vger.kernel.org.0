Return-Path: <linux-s390+bounces-1583-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CA284E535
	for <lists+linux-s390@lfdr.de>; Thu,  8 Feb 2024 17:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB7B1C253B9
	for <lists+linux-s390@lfdr.de>; Thu,  8 Feb 2024 16:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75278288A;
	Thu,  8 Feb 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QupVsoKt"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D415581ACC;
	Thu,  8 Feb 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410580; cv=none; b=YrSDhO+I5Tpn0gMtqexCEWFJNdg4x8/CQFG0La3PN+Xx68LENoviX3rm15n8EZAmNVxhq5Hk33A0H8lEEV6LqUffEcBiNluIXcdN+xMuyIIdgYj+TE+LBGYxBwr1yAY4jOfJ1mmkQBpoXNZW5R3SZ9RcDO9y7fAZ5V2LOTnqBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410580; c=relaxed/simple;
	bh=tODtCjoQxDmf9WOlbqyAWplFbD3hw6nR4vyUSntzbRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhQtp13bzTf6UMTY4WaknoKlkn55/S6HC4ZocTHlzu8dKncPw/Y1w9WgznO8JZXyOZczp2MdSGTh6C0XFUJSYHGmx8ku3MqUfM9irytIteKY1h1LeeecW/QB/UCI8WVwErqTqCDFsSVLVOaCM37oxUnixSb7qkI+nwlRY2uvG/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QupVsoKt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418GcVlx028555;
	Thu, 8 Feb 2024 16:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=LXrR67UlmTcaNgIY9xfIVR0QdYtShEzidKKjgzYEkCM=;
 b=QupVsoKtV6g0c6t+44c8I/JoTf7GivEj5/fqZGe8OhmJkim3lV1gpg4/H6Xoglms4qnc
 igzodTt/OypvHpip1CrPL+oJ43W9uqBc1qhc0XvnmO8blj1R++HGqIOgptWdtwLsblEU
 lZYVzKIaHaRP2STFZaNp6RHkr93LBXXy6Eu2ZGVFf253i1Hc901U5W89PTeioGLaJGJM
 /cmnXhLXq4MotOssDIqsI4uWwZ7JxC3fIAAmIEB3M7X9mZcF0pGoVqhJgLKpkCKAOINB
 e7Ewr7aPhW8aO+JOtcneh6uZyiDgk5KO4mix4w3M+T5CszwwfixO6Cq6gs9st69a8gZJ Kw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w52n8r38q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:55 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418FHBBH014765;
	Thu, 8 Feb 2024 16:42:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tp5nes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418GgmBT30409378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 16:42:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0E382004D;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0D4C20043;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 49120E1541; Thu,  8 Feb 2024 17:42:48 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Miroslav Franc <mfranc@suse.cz>
Subject: [PATCH RESEND 05/11] s390/dasd: Remove unused message logging macros
Date: Thu,  8 Feb 2024 17:42:44 +0100
Message-Id: <20240208164248.540985-6-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240208164248.540985-1-sth@linux.ibm.com>
References: <20240208164248.540985-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yVyhQYkj2E84pHSB3QgJZC35mzwmN1YS
X-Proofpoint-ORIG-GUID: yVyhQYkj2E84pHSB3QgJZC35mzwmN1YS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=860
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080088

From: Jan Höppner <hoeppner@linux.ibm.com>

The macros DEV_MESSAGE, MESSAGE, DEV_MESSAGE_LOG, and MESSAGE_LOG, are
not used and there is no history anymore of any usage. Remove them.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_int.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 71d88e931090..a6c5f1fa2d87 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -123,32 +123,6 @@ do { \
 #define	DBF_INFO	6	/* informational			*/
 #define	DBF_DEBUG	6	/* debug-level messages			*/
 
-/* messages to be written via klogd and dbf */
-#define DEV_MESSAGE(d_loglevel,d_device,d_string,d_args...)\
-do { \
-	printk(d_loglevel PRINTK_HEADER " %s: " d_string "\n", \
-	       dev_name(&d_device->cdev->dev), d_args); \
-	DBF_DEV_EVENT(DBF_ALERT, d_device, d_string, d_args); \
-} while(0)
-
-#define MESSAGE(d_loglevel,d_string,d_args...)\
-do { \
-	printk(d_loglevel PRINTK_HEADER " " d_string "\n", d_args); \
-	DBF_EVENT(DBF_ALERT, d_string, d_args); \
-} while(0)
-
-/* messages to be written via klogd only */
-#define DEV_MESSAGE_LOG(d_loglevel,d_device,d_string,d_args...)\
-do { \
-	printk(d_loglevel PRINTK_HEADER " %s: " d_string "\n", \
-	       dev_name(&d_device->cdev->dev), d_args); \
-} while(0)
-
-#define MESSAGE_LOG(d_loglevel,d_string,d_args...)\
-do { \
-	printk(d_loglevel PRINTK_HEADER " " d_string "\n", d_args); \
-} while(0)
-
 /* Macro to calculate number of blocks per page */
 #define BLOCKS_PER_PAGE(blksize) (PAGE_SIZE / blksize)
 
-- 
2.40.1


