Return-Path: <linux-s390+bounces-6531-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DE499E59F
	for <lists+linux-s390@lfdr.de>; Tue, 15 Oct 2024 13:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37C61F24A0F
	for <lists+linux-s390@lfdr.de>; Tue, 15 Oct 2024 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73ED1E3DF2;
	Tue, 15 Oct 2024 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GPDKyeYE"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D61D89F5;
	Tue, 15 Oct 2024 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991747; cv=none; b=l8/u/tgqqPL6CV+sWfjbKAh0Mis7bhU5pg5mqs3ARHH2a+Rq3oSOwgtm0HI/Sj6Ok0OyCDgytzMstnjbmksilTrOcaj2Qd4wxfN8STbPbFSKstLh18n5x2DLzM7n8Y0zSXtB+XqwyU/JVkqII+28DcNWPrGA5HDt7bWfJX6UtkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991747; c=relaxed/simple;
	bh=1cPpdHGl6lDhsgHroNi8lCrJp1Ba8KhRimLxI5LF4VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7/KUm1IZG6gQqqwijI0YXc7vFvTlYLU4Nt5zppPbE/8AzlQSFSGJRY2aJGhzvgQhJcm9uB0LLRS52gB+opYOgRBpTAz1uoKxiY2bJs3HxIijoVFzg1brOG1LV3TbKy47uzdCMs5aeZwQPay5BiX3tZDq1fregSRd82gnTprgPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GPDKyeYE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAstQ5012167;
	Tue, 15 Oct 2024 11:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JfRqi6Yj/eKU/oFhQ
	Z1JTLP0zhPMogS8T2ug5DdABOQ=; b=GPDKyeYEDrULWGA8MnW+LsqQ7kotVlEin
	NoY3Kdyi5BX6y0J9sIb1sUCOrIyLotQ9SBU16SqSMUCr6WfcKnQ00uzhXNQLlzvv
	VCjoyWIp1MY7h+3a+XEuzAkT5so8TjrGV1c2siKmqWyGp7JoSsZultNecqbvJABV
	B+bCoGud8tQsI8MulUvj0/x/MMcOE9nUnPTKwW/NVLA5y7NhpbgEiNrTR0OPXWZz
	Vuhsm4Xd91fvcD64BSl91pLgZM0Yng3bkBCdr3ZsGMDDHVdm6cJMNZ1HvGgpIw6n
	KzzAW+Rr4YE2fM2Tr0dz7UuINxtCycNTvMTUlGQvWvYGPxXfhIG3Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429q2fg56v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:29:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAHsgD006678;
	Tue, 15 Oct 2024 11:29:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283eruq5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:29:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FBT0eL45154720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 11:29:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8622120043;
	Tue, 15 Oct 2024 11:29:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60C1E2004E;
	Tue, 15 Oct 2024 11:29:00 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 11:29:00 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v3 3/6] s390/uvdevice: Add Retrieve Secret IOCTL
Date: Tue, 15 Oct 2024 13:28:56 +0200
Message-ID: <20241015112859.3069210-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015112859.3069210-1-seiden@linux.ibm.com>
References: <20241015112859.3069210-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XZgnggdbbbBZOi0LlK8znxQBXlqM5jjJ
X-Proofpoint-GUID: XZgnggdbbbBZOi0LlK8znxQBXlqM5jjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=849
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150078

Add a new IOCL number to support the new Retrieve Secret UVC for
user-space.
User-space provides the index of the secret (u16) to retrieve.
The uvdevice calls the Retrieve Secret UVC and copies the secret into
the provided buffer if it fits. To get the secret type, index, and size
user-space needs to call the List UVC first.

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/uapi/asm/uvdevice.h |  6 ++-
 drivers/s390/char/uvdevice.c          | 58 ++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/uapi/asm/uvdevice.h b/arch/s390/include/uapi/asm/uvdevice.h
index b9c2f14a6af3..2ee5bfc61800 100644
--- a/arch/s390/include/uapi/asm/uvdevice.h
+++ b/arch/s390/include/uapi/asm/uvdevice.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
- *  Copyright IBM Corp. 2022
+ *  Copyright IBM Corp. 2022, 2024
  *  Author(s): Steffen Eiden <seiden@linux.ibm.com>
  */
 #ifndef __S390_ASM_UVDEVICE_H
@@ -71,6 +71,7 @@ struct uvio_uvdev_info {
 #define UVIO_ATT_ADDITIONAL_MAX_LEN	0x8000
 #define UVIO_ADD_SECRET_MAX_LEN		0x100000
 #define UVIO_LIST_SECRETS_LEN		0x1000
+#define UVIO_RETR_SECRET_MAX_LEN	0x2000
 
 #define UVIO_DEVICE_NAME "uv"
 #define UVIO_TYPE_UVC 'u'
@@ -81,6 +82,7 @@ enum UVIO_IOCTL_NR {
 	UVIO_IOCTL_ADD_SECRET_NR,
 	UVIO_IOCTL_LIST_SECRETS_NR,
 	UVIO_IOCTL_LOCK_SECRETS_NR,
+	UVIO_IOCTL_RETR_SECRET_NR,
 	/* must be the last entry */
 	UVIO_IOCTL_NUM_IOCTLS
 };
@@ -91,6 +93,7 @@ enum UVIO_IOCTL_NR {
 #define UVIO_IOCTL_ADD_SECRET	UVIO_IOCTL(UVIO_IOCTL_ADD_SECRET_NR)
 #define UVIO_IOCTL_LIST_SECRETS	UVIO_IOCTL(UVIO_IOCTL_LIST_SECRETS_NR)
 #define UVIO_IOCTL_LOCK_SECRETS	UVIO_IOCTL(UVIO_IOCTL_LOCK_SECRETS_NR)
+#define UVIO_IOCTL_RETR_SECRET	UVIO_IOCTL(UVIO_IOCTL_RETR_SECRET_NR)
 
 #define UVIO_SUPP_CALL(nr)	(1ULL << (nr))
 #define UVIO_SUPP_UDEV_INFO	UVIO_SUPP_CALL(UVIO_IOCTL_UDEV_INFO_NR)
@@ -98,5 +101,6 @@ enum UVIO_IOCTL_NR {
 #define UVIO_SUPP_ADD_SECRET	UVIO_SUPP_CALL(UVIO_IOCTL_ADD_SECRET_NR)
 #define UVIO_SUPP_LIST_SECRETS	UVIO_SUPP_CALL(UVIO_IOCTL_LIST_SECRETS_NR)
 #define UVIO_SUPP_LOCK_SECRETS	UVIO_SUPP_CALL(UVIO_IOCTL_LOCK_SECRETS_NR)
+#define UVIO_SUPP_RETR_SECRET	UVIO_SUPP_CALL(UVIO_IOCTL_RETR_SECRET_NR)
 
 #endif /* __S390_ASM_UVDEVICE_H */
diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index f598edc5f251..1f90976293e8 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  Copyright IBM Corp. 2022
+ *  Copyright IBM Corp. 2022, 2024
  *  Author(s): Steffen Eiden <seiden@linux.ibm.com>
  *
  *  This file provides a Linux misc device to give userspace access to some
@@ -40,6 +40,7 @@ static const u32 ioctl_nr_to_uvc_bit[] __initconst = {
 	[UVIO_IOCTL_ADD_SECRET_NR] = BIT_UVC_CMD_ADD_SECRET,
 	[UVIO_IOCTL_LIST_SECRETS_NR] = BIT_UVC_CMD_LIST_SECRETS,
 	[UVIO_IOCTL_LOCK_SECRETS_NR] = BIT_UVC_CMD_LOCK_SECRETS,
+	[UVIO_IOCTL_RETR_SECRET_NR] = BIT_UVC_CMD_RETR_ATTEST,
 };
 
 static_assert(ARRAY_SIZE(ioctl_nr_to_uvc_bit) == UVIO_IOCTL_NUM_IOCTLS);
@@ -379,6 +380,58 @@ static int uvio_lock_secrets(struct uvio_ioctl_cb *ioctl)
 	return 0;
 }
 
+/**
+ * uvio_retr_secret() - perform a retrieve secret UVC.
+ * @uv_ioctl: ioctl control block.
+ *
+ * uvio_retr_secret() performs the Retrieve Secret Ultravisor Call.
+ * The first two bytes of the argument specify the index of the secret to be
+ * retrieved. The retrieved secret is copied into the argument buffer if there
+ * is enough space.
+ * The argument length must be at least two bytes and at max 8192 bytes.
+ *
+ * Context: might sleep.
+ *
+ * Return: 0 on success or a negative error code on error.
+ */
+static int uvio_retr_secret(struct uvio_ioctl_cb *uv_ioctl)
+{
+	u16 __user *user_index = (u16 __user *)uv_ioctl->argument_addr;
+	struct uv_cb_retr_secr uvcb = {
+		.header.len = sizeof(uvcb),
+		.header.cmd = UVC_CMD_RETR_SECRET,
+	};
+	u32 buf_len = uv_ioctl->argument_len;
+	void *buf = NULL;
+	int ret;
+
+	if (buf_len > UVIO_RETR_SECRET_MAX_LEN || buf_len < sizeof(*user_index))
+		return -EINVAL;
+
+	buf = kvzalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = -EFAULT;
+	if (get_user(uvcb.secret_idx, user_index))
+		goto err;
+
+	uvcb.buf_addr = (u64)buf;
+	uvcb.buf_size = buf_len;
+	uv_call_sched(0, (u64)&uvcb);
+
+	if (copy_to_user((__user void *)uv_ioctl->argument_addr, buf, buf_len))
+		goto err;
+
+	ret = 0;
+	uv_ioctl->uv_rc = uvcb.header.rc;
+	uv_ioctl->uv_rrc = uvcb.header.rrc;
+
+err:
+	kvfree_sensitive(buf, buf_len);
+	return ret;
+}
+
 static int uvio_copy_and_check_ioctl(struct uvio_ioctl_cb *ioctl, void __user *argp,
 				     unsigned long cmd)
 {
@@ -432,6 +485,9 @@ static long uvio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case UVIO_IOCTL_LOCK_SECRETS_NR:
 		ret = uvio_lock_secrets(&uv_ioctl);
 		break;
+	case UVIO_IOCTL_RETR_SECRET_NR:
+		ret = uvio_retr_secret(&uv_ioctl);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
-- 
2.43.0


