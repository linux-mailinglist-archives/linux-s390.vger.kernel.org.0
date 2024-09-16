Return-Path: <linux-s390+bounces-6096-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D861979FA5
	for <lists+linux-s390@lfdr.de>; Mon, 16 Sep 2024 12:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965D0B20B94
	for <lists+linux-s390@lfdr.de>; Mon, 16 Sep 2024 10:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F96155732;
	Mon, 16 Sep 2024 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pUwGdKCO"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C93B154435;
	Mon, 16 Sep 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483557; cv=none; b=q7W0oBWcHqleDj65x/tq5MI3NX5YhVboDZU97AN6gzmQyadawp8RHHSd24UM0eQ+C3Fx8hqSkxwkHUZSqVC+avNsacmt1CWOSVLZZHx3Q7aZ8a5LYK9JSBNNq40BiQ5jlGKULQgPi7J3RX9QnVtNwDLHJoZqmhIpZjpYOTWQT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483557; c=relaxed/simple;
	bh=EdFKf8qRllrodtdfPhCRlXdSpcJQP/fVxPEzzbXuICk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQ3e86cN2UV6r2MB5rYbTV4D9/fCKL/Yc1rjkxTWw/kjrAzrUowBaPebMzaRaDgeU4MY1KuLcGG1qL3mBObhWf2CAiD4vktdOdd1NlKBETelRMLdTWnqS6hEfby8AanUQgiHaP1MmH6oHFA85JA0v2so+bLw9S2LfIAn2uftzyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pUwGdKCO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48FMiuU8005858;
	Mon, 16 Sep 2024 10:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:mime-version; s=pp1; bh=HY88a0us02dM8
	8bUboDF9dB/GsAZOYlPGciRcy7grmI=; b=pUwGdKCOhABMlUBBcKiF9ZVqX9qg+
	OU75jtg6+QHfUmj99UIJxVhRrqoMdsLCdLyHEEO/BoqNU6tjEK1TCFh/u+ejRTiH
	2EDkAeX7/pmPShgJAHu+JD+uyexlKcy4wPWEqfGhvBlrAFOS1v6GCL12GrQcA7tE
	tp4LEBY6Aa3cbt3es12s6HEa0ikJO+315Hy/DbkU8mz0cJ2gQZsICTvj7q8BaYUv
	QvgL3UfcKeVBEFsZkaO1VPN2PCNZP1Gzhm453WC5BcMqXpsU7c5kN0drv0CIEmma
	rorzzaT0T+SgKe1+AjUxznX84mF7F4JMP9cgMqeJIeZTuBqp3Ihp/eE5A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vd99v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 10:45:48 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48GAjmF1029716;
	Mon, 16 Sep 2024 10:45:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vd99uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 10:45:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48G8SUaU000723;
	Mon, 16 Sep 2024 10:45:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nntpxqyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Sep 2024 10:45:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48GAjgIu57147766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 10:45:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B83B20040;
	Mon, 16 Sep 2024 10:45:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B00220049;
	Mon, 16 Sep 2024 10:45:42 +0000 (GMT)
Received: from li-9fd7f64c-3205-11b2-a85c-df942b00d78d.ibm.com.com (unknown [9.179.30.170])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Sep 2024 10:45:42 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [GIT PULL 3/8] selftests: kvm: s390: Add kvm_s390_sie_block definition for userspace tests
Date: Mon, 16 Sep 2024 12:42:58 +0200
Message-ID: <20240916104458.66521-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916104458.66521-1-frankja@linux.ibm.com>
References: <20240916104458.66521-1-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 17I8BATqGef33kQVE4vq_rOdcwTCtsGy
X-Proofpoint-GUID: -2Df7S173LE0BzWarJPe-YZ4Ld73dPKj
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_06,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409160065

From: Christoph Schlameuss <schlameuss@linux.ibm.com>

Subsequent tests do require direct manipulation of the SIE control
block. This commit introduces the SIE control block definition for use
within the selftests.

There are already definitions of this within the kernel.
This differs in two ways.
* This is the first definition of this in userspace.
* In the context of the selftests this does not require atomicity for
  the flags.

With the userspace definition of the SIE block layout now being present
we can reuse the values in other tests where applicable.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Link: https://lore.kernel.org/r/20240807154512.316936-3-schlameuss@linux.ibm.com
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <20240807154512.316936-3-schlameuss@linux.ibm.com>
---
 .../testing/selftests/kvm/include/s390x/sie.h | 240 ++++++++++++++++++
 .../testing/selftests/kvm/s390x/debug_test.c  |   4 +-
 2 files changed, 242 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/s390x/sie.h

diff --git a/tools/testing/selftests/kvm/include/s390x/sie.h b/tools/testing/selftests/kvm/include/s390x/sie.h
new file mode 100644
index 000000000000..160acd4a1db9
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/s390x/sie.h
@@ -0,0 +1,240 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Definition for kernel virtual machines on s390.
+ *
+ * Adapted copy of struct definition kvm_s390_sie_block from
+ * arch/s390/include/asm/kvm_host.h for use in userspace selftest programs.
+ *
+ * Copyright IBM Corp. 2008, 2024
+ *
+ * Authors:
+ *  Christoph Schlameuss <schlameuss@linux.ibm.com>
+ *  Carsten Otte <cotte@de.ibm.com>
+ */
+
+#ifndef SELFTEST_KVM_SIE_H
+#define SELFTEST_KVM_SIE_H
+
+#include <linux/types.h>
+
+struct kvm_s390_sie_block {
+#define CPUSTAT_STOPPED    0x80000000
+#define CPUSTAT_WAIT       0x10000000
+#define CPUSTAT_ECALL_PEND 0x08000000
+#define CPUSTAT_STOP_INT   0x04000000
+#define CPUSTAT_IO_INT     0x02000000
+#define CPUSTAT_EXT_INT    0x01000000
+#define CPUSTAT_RUNNING    0x00800000
+#define CPUSTAT_RETAINED   0x00400000
+#define CPUSTAT_TIMING_SUB 0x00020000
+#define CPUSTAT_SIE_SUB    0x00010000
+#define CPUSTAT_RRF        0x00008000
+#define CPUSTAT_SLSV       0x00004000
+#define CPUSTAT_SLSR       0x00002000
+#define CPUSTAT_ZARCH      0x00000800
+#define CPUSTAT_MCDS       0x00000100
+#define CPUSTAT_KSS        0x00000200
+#define CPUSTAT_SM         0x00000080
+#define CPUSTAT_IBS        0x00000040
+#define CPUSTAT_GED2       0x00000010
+#define CPUSTAT_G          0x00000008
+#define CPUSTAT_GED        0x00000004
+#define CPUSTAT_J          0x00000002
+#define CPUSTAT_P          0x00000001
+	__u32 cpuflags;			/* 0x0000 */
+	__u32: 1;			/* 0x0004 */
+	__u32 prefix : 18;
+	__u32: 1;
+	__u32 ibc : 12;
+	__u8	reserved08[4];		/* 0x0008 */
+#define PROG_IN_SIE BIT(0)
+	__u32	prog0c;			/* 0x000c */
+	union {
+		__u8	reserved10[16];	/* 0x0010 */
+		struct {
+			__u64	pv_handle_cpu;
+			__u64	pv_handle_config;
+		};
+	};
+#define PROG_BLOCK_SIE	BIT(0)
+#define PROG_REQUEST	BIT(1)
+	__u32	prog20;			/* 0x0020 */
+	__u8	reserved24[4];		/* 0x0024 */
+	__u64	cputm;			/* 0x0028 */
+	__u64	ckc;			/* 0x0030 */
+	__u64	epoch;			/* 0x0038 */
+	__u32	svcc;			/* 0x0040 */
+#define LCTL_CR0	0x8000
+#define LCTL_CR6	0x0200
+#define LCTL_CR9	0x0040
+#define LCTL_CR10	0x0020
+#define LCTL_CR11	0x0010
+#define LCTL_CR14	0x0002
+	__u16   lctl;			/* 0x0044 */
+	__s16	icpua;			/* 0x0046 */
+#define ICTL_OPEREXC	0x80000000
+#define ICTL_PINT	0x20000000
+#define ICTL_LPSW	0x00400000
+#define ICTL_STCTL	0x00040000
+#define ICTL_ISKE	0x00004000
+#define ICTL_SSKE	0x00002000
+#define ICTL_RRBE	0x00001000
+#define ICTL_TPROT	0x00000200
+	__u32	ictl;			/* 0x0048 */
+#define ECA_CEI		0x80000000
+#define ECA_IB		0x40000000
+#define ECA_SIGPI	0x10000000
+#define ECA_MVPGI	0x01000000
+#define ECA_AIV		0x00200000
+#define ECA_VX		0x00020000
+#define ECA_PROTEXCI	0x00002000
+#define ECA_APIE	0x00000008
+#define ECA_SII		0x00000001
+	__u32	eca;			/* 0x004c */
+#define ICPT_INST	0x04
+#define ICPT_PROGI	0x08
+#define ICPT_INSTPROGI	0x0C
+#define ICPT_EXTREQ	0x10
+#define ICPT_EXTINT	0x14
+#define ICPT_IOREQ	0x18
+#define ICPT_WAIT	0x1c
+#define ICPT_VALIDITY	0x20
+#define ICPT_STOP	0x28
+#define ICPT_OPEREXC	0x2C
+#define ICPT_PARTEXEC	0x38
+#define ICPT_IOINST	0x40
+#define ICPT_KSS	0x5c
+#define ICPT_MCHKREQ	0x60
+#define ICPT_INT_ENABLE	0x64
+#define ICPT_PV_INSTR	0x68
+#define ICPT_PV_NOTIFY	0x6c
+#define ICPT_PV_PREF	0x70
+	__u8	icptcode;		/* 0x0050 */
+	__u8	icptstatus;		/* 0x0051 */
+	__u16	ihcpu;			/* 0x0052 */
+	__u8	reserved54;		/* 0x0054 */
+#define IICTL_CODE_NONE		 0x00
+#define IICTL_CODE_MCHK		 0x01
+#define IICTL_CODE_EXT		 0x02
+#define IICTL_CODE_IO		 0x03
+#define IICTL_CODE_RESTART	 0x04
+#define IICTL_CODE_SPECIFICATION 0x10
+#define IICTL_CODE_OPERAND	 0x11
+	__u8	iictl;			/* 0x0055 */
+	__u16	ipa;			/* 0x0056 */
+	__u32	ipb;			/* 0x0058 */
+	__u32	scaoh;			/* 0x005c */
+#define FPF_BPBC	0x20
+	__u8	fpf;			/* 0x0060 */
+#define ECB_GS		0x40
+#define ECB_TE		0x10
+#define ECB_SPECI	0x08
+#define ECB_SRSI	0x04
+#define ECB_HOSTPROTINT	0x02
+#define ECB_PTF		0x01
+	__u8	ecb;			/* 0x0061 */
+#define ECB2_CMMA	0x80
+#define ECB2_IEP	0x20
+#define ECB2_PFMFI	0x08
+#define ECB2_ESCA	0x04
+#define ECB2_ZPCI_LSI	0x02
+	__u8	ecb2;			/* 0x0062 */
+#define ECB3_AISI	0x20
+#define ECB3_AISII	0x10
+#define ECB3_DEA	0x08
+#define ECB3_AES	0x04
+#define ECB3_RI		0x01
+	__u8	ecb3;			/* 0x0063 */
+#define ESCA_SCAOL_MASK ~0x3fU
+	__u32	scaol;			/* 0x0064 */
+	__u8	sdf;			/* 0x0068 */
+	__u8	epdx;			/* 0x0069 */
+	__u8	cpnc;			/* 0x006a */
+	__u8	reserved6b;		/* 0x006b */
+	__u32	todpr;			/* 0x006c */
+#define GISA_FORMAT1 0x00000001
+	__u32	gd;			/* 0x0070 */
+	__u8	reserved74[12];		/* 0x0074 */
+	__u64	mso;			/* 0x0080 */
+	__u64	msl;			/* 0x0088 */
+	__u64	psw_mask;		/* 0x0090 */
+	__u64	psw_addr;		/* 0x0098 */
+	__u64	gg14;			/* 0x00a0 */
+	__u64	gg15;			/* 0x00a8 */
+	__u8	reservedb0[8];		/* 0x00b0 */
+#define HPID_KVM	0x4
+#define HPID_VSIE	0x5
+	__u8	hpid;			/* 0x00b8 */
+	__u8	reservedb9[7];		/* 0x00b9 */
+	union {
+		struct {
+			__u32	eiparams;	/* 0x00c0 */
+			__u16	extcpuaddr;	/* 0x00c4 */
+			__u16	eic;		/* 0x00c6 */
+		};
+		__u64	mcic;			/* 0x00c0 */
+	} __packed;
+	__u32	reservedc8;		/* 0x00c8 */
+	union {
+		struct {
+			__u16	pgmilc;		/* 0x00cc */
+			__u16	iprcc;		/* 0x00ce */
+		};
+		__u32	edc;			/* 0x00cc */
+	} __packed;
+	union {
+		struct {
+			__u32	dxc;		/* 0x00d0 */
+			__u16	mcn;		/* 0x00d4 */
+			__u8	perc;		/* 0x00d6 */
+			__u8	peratmid;	/* 0x00d7 */
+		};
+		__u64	faddr;			/* 0x00d0 */
+	} __packed;
+	__u64	peraddr;		/* 0x00d8 */
+	__u8	eai;			/* 0x00e0 */
+	__u8	peraid;			/* 0x00e1 */
+	__u8	oai;			/* 0x00e2 */
+	__u8	armid;			/* 0x00e3 */
+	__u8	reservede4[4];		/* 0x00e4 */
+	union {
+		__u64	tecmc;		/* 0x00e8 */
+		struct {
+			__u16	subchannel_id;	/* 0x00e8 */
+			__u16	subchannel_nr;	/* 0x00ea */
+			__u32	io_int_parm;	/* 0x00ec */
+			__u32	io_int_word;	/* 0x00f0 */
+		};
+	} __packed;
+	__u8	reservedf4[8];		/* 0x00f4 */
+#define CRYCB_FORMAT_MASK	0x00000003
+#define CRYCB_FORMAT0		0x00000000
+#define CRYCB_FORMAT1		0x00000001
+#define CRYCB_FORMAT2		0x00000003
+	__u32	crycbd;			/* 0x00fc */
+	__u64	gcr[16];		/* 0x0100 */
+	union {
+		__u64	gbea;		/* 0x0180 */
+		__u64	sidad;
+	};
+	__u8    reserved188[8];		/* 0x0188 */
+	__u64   sdnxo;			/* 0x0190 */
+	__u8    reserved198[8];		/* 0x0198 */
+	__u32	fac;			/* 0x01a0 */
+	__u8	reserved1a4[20];	/* 0x01a4 */
+	__u64	cbrlo;			/* 0x01b8 */
+	__u8	reserved1c0[8];		/* 0x01c0 */
+#define ECD_HOSTREGMGMT	0x20000000
+#define ECD_MEF		0x08000000
+#define ECD_ETOKENF	0x02000000
+#define ECD_ECC		0x00200000
+	__u32	ecd;			/* 0x01c8 */
+	__u8	reserved1cc[18];	/* 0x01cc */
+	__u64	pp;			/* 0x01de */
+	__u8	reserved1e6[2];		/* 0x01e6 */
+	__u64	itdba;			/* 0x01e8 */
+	__u64   riccbd;			/* 0x01f0 */
+	__u64	gvrd;			/* 0x01f8 */
+} __packed __aligned(512);
+
+#endif /* SELFTEST_KVM_SIE_H */
diff --git a/tools/testing/selftests/kvm/s390x/debug_test.c b/tools/testing/selftests/kvm/s390x/debug_test.c
index 84313fb27529..ad8095968601 100644
--- a/tools/testing/selftests/kvm/s390x/debug_test.c
+++ b/tools/testing/selftests/kvm/s390x/debug_test.c
@@ -2,12 +2,12 @@
 /* Test KVM debugging features. */
 #include "kvm_util.h"
 #include "test_util.h"
+#include "sie.h"
 
 #include <linux/kvm.h>
 
 #define __LC_SVC_NEW_PSW 0x1c0
 #define __LC_PGM_NEW_PSW 0x1d0
-#define ICPT_INSTRUCTION 0x04
 #define IPA0_DIAG 0x8300
 #define PGM_SPECIFICATION 0x06
 
@@ -85,7 +85,7 @@ static void test_step_pgm_diag(void)
 	vm = test_step_int_1(&vcpu, test_step_pgm_diag_guest_code,
 			     __LC_PGM_NEW_PSW, new_psw);
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_S390_SIEIC);
-	TEST_ASSERT_EQ(vcpu->run->s390_sieic.icptcode, ICPT_INSTRUCTION);
+	TEST_ASSERT_EQ(vcpu->run->s390_sieic.icptcode, ICPT_INST);
 	TEST_ASSERT_EQ(vcpu->run->s390_sieic.ipa & 0xff00, IPA0_DIAG);
 	vcpu_ioctl(vcpu, KVM_S390_IRQ, &irq);
 	vcpu_run(vcpu);
-- 
2.46.0


