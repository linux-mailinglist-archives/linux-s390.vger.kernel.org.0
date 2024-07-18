Return-Path: <linux-s390+bounces-5013-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E276934C10
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jul 2024 12:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ADD0B21B92
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jul 2024 10:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349BF12C484;
	Thu, 18 Jul 2024 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WvfrJjaR"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339C1EA80;
	Thu, 18 Jul 2024 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300189; cv=none; b=nInINJ7zm1n8KCjEnfOJc3Fexu6deV2K5JVe41cyNV5QqT2WHoQMd68oMSBzBgPjA/4ybvBltz09+IZ/J9JJreYg2YShZ8G9QJ/XpCxQ8Q06te0/QDafNF0+kRgeijcV5KOJ2Exk6IpAt7uR9GwqDnbnIsiANIcNTDMamWbWMuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300189; c=relaxed/simple;
	bh=JSc9xUZKo6A2//1jLMem/oSwVDccrQehR6QdHnPy/U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5oIsI3UQI7aTaCBUHTmL+No/05ei6as7nfJH6bjgfuaca6tGvesb4aYB0gfsL+eE74CzYO9oj6ksV4rqaJIzQp84a3Cen/7T3BIGdCmJCYivzIgse0zV4+Ubsp4IcjUDgGhQm+plsGIpFsWeaPD5R3jswPsdV0UjZF59zDAFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WvfrJjaR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I8dWlD013645;
	Thu, 18 Jul 2024 10:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=9yRUypCBoAe43
	NrzoDicduyWJmN4nSJTtXcPskW61R8=; b=WvfrJjaRa2M1+lMf37QeXPIhrGAua
	t/9KlT/A0c/7UmmC8+/pVj2/fIiSinJhm6fvIfGohy2YbKR6eBw/C6l93dXpRCgV
	rrdbcQBK5MUvfkTM1s58LPyW6suwkI+ykOuwr8rBAYxOfTub2ocBulr/GhColFya
	8Ki9G1ZlK9VnSVRQF9M5tyZhhSSR7ovfzRlErdsjaZZ7PjW0W1SsHV59ZLs7isOG
	3CJWijTYgcitgSDcnVmaCSa+WPBeqo7AhhzjOwjr2LaemFnfLFrpgCq8nVSivk0S
	poO6+Koo8zU4bo5t6vPYbkKaDrhAtJBIgOtKvNgRz6SLr6ZevY5rRSB7Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ey4m8c74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 10:56:24 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46IAuOIo016462;
	Thu, 18 Jul 2024 10:56:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ey4m8c32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 10:56:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46I97egU000547;
	Thu, 18 Jul 2024 10:52:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40dwkk96rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 10:52:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46IAqPoO51052880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 10:52:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 152722004E;
	Thu, 18 Jul 2024 10:52:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1B702004F;
	Thu, 18 Jul 2024 10:52:24 +0000 (GMT)
Received: from a46lp67.lnxne.boe (unknown [9.152.108.100])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jul 2024 10:52:24 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, nrb@linux.ibm.com,
        npiggin@gmail.com, nsg@linux.ibm.com, mhartmay@linux.ibm.com
Subject: [kvm-unit-tests PATCH 4/4] lib: s390x: Split SIE fw structs from lib structs
Date: Thu, 18 Jul 2024 10:50:19 +0000
Message-ID: <20240718105104.34154-5-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718105104.34154-1-frankja@linux.ibm.com>
References: <20240718105104.34154-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: casGxXQkK56sPEjNhiFpC_6CSiDyDlih
X-Proofpoint-ORIG-GUID: ReRxpH47D7unfTVlBoJYV78wsVqkPakM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_07,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407180072

The SIE control block is huge and takes up too much space.

Additionally sie.h will now only contain sie lib structs and
declarations so we have a clear divide about which header contains
which things.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/{sie.h => asm/sie-arch.h} |  58 +------
 lib/s390x/sie.h                     | 231 +---------------------------
 2 files changed, 4 insertions(+), 285 deletions(-)
 copy lib/s390x/{sie.h => asm/sie-arch.h} (81%)

diff --git a/lib/s390x/sie.h b/lib/s390x/asm/sie-arch.h
similarity index 81%
copy from lib/s390x/sie.h
copy to lib/s390x/asm/sie-arch.h
index c1724cf2..4911c988 100644
--- a/lib/s390x/sie.h
+++ b/lib/s390x/asm/sie-arch.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _S390X_SIE_H_
-#define _S390X_SIE_H_
+#ifndef _S390X_SIE_ARCH_H_
+#define _S390X_SIE_ARCH_H_
 
 #include <stdint.h>
 #include <asm/arch_def.h>
@@ -235,56 +235,4 @@ struct esca_block {
 	struct esca_entry cpu[256];
 };
 
-struct vm_uv {
-	uint64_t vm_handle;
-	uint64_t vcpu_handle;
-	uint64_t asce;
-	void *conf_base_stor;
-	void *conf_var_stor;
-	void *cpu_stor;
-};
-
-struct vm_save_regs {
-	uint64_t asce;
-	uint64_t grs[16];
-	uint64_t fprs[16];
-	uint32_t fpc;
-};
-
-/* We might be able to nestle all of this into the stack frame. But
- * having a dedicated save area that saves more than the s390 ELF ABI
- * defines leaves us more freedom in the implementation.
-*/
-struct vm_save_area {
-	struct vm_save_regs guest;
-	struct vm_save_regs host;
-};
-
-struct vm {
-	struct kvm_s390_sie_block *sblk;
-	struct vm_save_area save_area;
-	struct esca_block *sca;			/* System Control Area */
-	uint8_t *crycb;				/* Crypto Control Block */
-	struct vm_uv uv;			/* PV UV information */
-	/* Ptr to first guest page */
-	uint8_t *guest_mem;
-	bool validity_expected;
-};
-
-extern void sie_entry(void);
-extern void sie_exit(void);
-extern void sie_entry_gregs(void);
-extern void sie_exit_gregs(void);
-extern void sie64a(struct kvm_s390_sie_block *sblk, struct vm_save_area *save_area);
-void sie(struct vm *vm);
-void sie_expect_validity(struct vm *vm);
-uint16_t sie_get_validity(struct vm *vm);
-void sie_check_validity(struct vm *vm, uint16_t vir_exp);
-void sie_handle_validity(struct vm *vm);
-void sie_guest_sca_create(struct vm *vm);
-void sie_guest_create(struct vm *vm, uint64_t guest_mem, uint64_t guest_mem_len);
-void sie_guest_destroy(struct vm *vm);
-
-uint8_t *sie_guest_alloc(uint64_t guest_size);
-
-#endif /* _S390X_SIE_H_ */
+#endif /* _S390X_SIE_ARCH_H_ */
diff --git a/lib/s390x/sie.h b/lib/s390x/sie.h
index c1724cf2..f13e698f 100644
--- a/lib/s390x/sie.h
+++ b/lib/s390x/sie.h
@@ -4,236 +4,7 @@
 
 #include <stdint.h>
 #include <asm/arch_def.h>
-
-#define CPUSTAT_STOPPED    0x80000000
-#define CPUSTAT_WAIT       0x10000000
-#define CPUSTAT_ECALL_PEND 0x08000000
-#define CPUSTAT_STOP_INT   0x04000000
-#define CPUSTAT_IO_INT     0x02000000
-#define CPUSTAT_EXT_INT    0x01000000
-#define CPUSTAT_RUNNING    0x00800000
-#define CPUSTAT_RETAINED   0x00400000
-#define CPUSTAT_TIMING_SUB 0x00020000
-#define CPUSTAT_SIE_SUB    0x00010000
-#define CPUSTAT_RRF        0x00008000
-#define CPUSTAT_SLSV       0x00004000
-#define CPUSTAT_SLSR       0x00002000
-#define CPUSTAT_ZARCH      0x00000800
-#define CPUSTAT_MCDS       0x00000100
-#define CPUSTAT_KSS        0x00000200
-#define CPUSTAT_SM         0x00000080
-#define CPUSTAT_IBS        0x00000040
-#define CPUSTAT_GED2       0x00000010
-#define CPUSTAT_G          0x00000008
-#define CPUSTAT_GED        0x00000004
-#define CPUSTAT_J          0x00000002
-#define CPUSTAT_P          0x00000001
-
-struct kvm_s390_sie_block {
-	uint32_t 	cpuflags;		/* 0x0000 */
-	uint32_t : 1;			/* 0x0004 */
-	uint32_t 	prefix : 18;
-	uint32_t : 1;
-	uint32_t 	ibc : 12;
-	uint8_t		reserved08[4];		/* 0x0008 */
-#define PROG_IN_SIE (1<<0)
-	uint32_t	prog0c;			/* 0x000c */
-union {
-		uint8_t	reserved10[16];		/* 0x0010 */
-		struct {
-			uint64_t	pv_handle_cpu;
-			uint64_t	pv_handle_config;
-		};
-	};
-#define PROG_BLOCK_SIE	(1<<0)
-#define PROG_REQUEST	(1<<1)
-	uint32_t 	prog20;		/* 0x0020 */
-	uint8_t		reserved24[4];		/* 0x0024 */
-	uint64_t	cputm;			/* 0x0028 */
-	uint64_t	ckc;			/* 0x0030 */
-	uint64_t	epoch;			/* 0x0038 */
-	uint32_t	svcc;			/* 0x0040 */
-#define LCTL_CR0	0x8000
-#define LCTL_CR6	0x0200
-#define LCTL_CR9	0x0040
-#define LCTL_CR10	0x0020
-#define LCTL_CR11	0x0010
-#define LCTL_CR14	0x0002
-	uint16_t   	lctl;			/* 0x0044 */
-	int16_t		icpua;			/* 0x0046 */
-#define ICTL_OPEREXC	0x80000000
-#define ICTL_PINT	0x20000000
-#define ICTL_LPSW	0x00400000
-#define ICTL_STCTL	0x00040000
-#define ICTL_ISKE	0x00004000
-#define ICTL_SSKE	0x00002000
-#define ICTL_RRBE	0x00001000
-#define ICTL_TPROT	0x00000200
-	uint32_t	ictl;			/* 0x0048 */
-#define ECA_CEI		0x80000000
-#define ECA_IB		0x40000000
-#define ECA_SIGPI	0x10000000
-#define ECA_MVPGI	0x01000000
-#define ECA_AIV		0x00200000
-#define ECA_VX		0x00020000
-#define ECA_PROTEXCI	0x00002000
-#define ECA_APIE	0x00000008
-#define ECA_SII		0x00000001
-	uint32_t	eca;			/* 0x004c */
-#define ICPT_INST	0x04
-#define ICPT_PROGI	0x08
-#define ICPT_INSTPROGI	0x0C
-#define ICPT_EXTREQ	0x10
-#define ICPT_EXTINT	0x14
-#define ICPT_IOREQ	0x18
-#define ICPT_WAIT	0x1c
-#define ICPT_VALIDITY	0x20
-#define ICPT_STOP	0x28
-#define ICPT_OPEREXC	0x2C
-#define ICPT_PARTEXEC	0x38
-#define ICPT_IOINST	0x40
-#define ICPT_KSS	0x5c
-#define ICPT_INT_ENABLE	0x64
-#define ICPT_PV_INSTR	0x68
-#define ICPT_PV_NOTIFY	0x6c
-#define ICPT_PV_PREF	0x70
-	uint8_t		icptcode;		/* 0x0050 */
-	uint8_t		icptstatus;		/* 0x0051 */
-	uint16_t	ihcpu;			/* 0x0052 */
-	uint8_t		reserved54;		/* 0x0054 */
-#define IICTL_CODE_NONE		 0x00
-#define IICTL_CODE_MCHK		 0x01
-#define IICTL_CODE_EXT		 0x02
-#define IICTL_CODE_IO		 0x03
-#define IICTL_CODE_RESTART	 0x04
-#define IICTL_CODE_SPECIFICATION 0x10
-#define IICTL_CODE_OPERAND	 0x11
-	uint8_t		iictl;			/* 0x0055 */
-	uint16_t	ipa;			/* 0x0056 */
-	uint32_t	ipb;			/* 0x0058 */
-	uint32_t	scaoh;			/* 0x005c */
-#define FPF_BPBC 	0x20
-	uint8_t		fpf;			/* 0x0060 */
-#define ECB_GS		0x40
-#define ECB_TE		0x10
-#define ECB_SPECI	0x08
-#define ECB_SRSI	0x04
-#define ECB_HOSTPROTINT	0x02
-	uint8_t		ecb;			/* 0x0061 */
-#define ECB2_CMMA	0x80
-#define ECB2_IEP	0x20
-#define ECB2_PFMFI	0x08
-#define ECB2_ESCA	0x04
-	uint8_t    	ecb2;                   /* 0x0062 */
-#define ECB3_DEA 0x08
-#define ECB3_AES 0x04
-#define ECB3_RI  0x01
-	uint8_t    	ecb3;			/* 0x0063 */
-	uint32_t	scaol;			/* 0x0064 */
-	uint8_t		sdf;			/* 0x0068 */
-	uint8_t    	epdx;			/* 0x0069 */
-	uint8_t    	reserved6a[2];		/* 0x006a */
-	uint32_t	todpr;			/* 0x006c */
-#define GISA_FORMAT1 0x00000001
-	uint32_t	gd;			/* 0x0070 */
-	uint8_t		reserved74[12];		/* 0x0074 */
-	uint64_t	mso;			/* 0x0080 */
-	uint64_t	msl;			/* 0x0088 */
-	struct psw	gpsw;			/* 0x0090 */
-	uint64_t	gg14;			/* 0x00a0 */
-	uint64_t	gg15;			/* 0x00a8 */
-	uint8_t		reservedb0[8];		/* 0x00b0 */
-#define HPID_KVM	0x4
-#define HPID_VSIE	0x5
-	uint8_t		hpid;			/* 0x00b8 */
-	uint8_t		reservedb9[7];		/* 0x00b9 */
-	union {
-		struct {
-			uint32_t	eiparams;	/* 0x00c0 */
-			uint16_t	extcpuaddr;	/* 0x00c4 */
-			uint16_t	eic;		/* 0x00c6 */
-		};
-		uint64_t	mcic;			/* 0x00c0 */
-	} __attribute__ ((__packed__));
-	uint32_t	reservedc8;		/* 0x00c8 */
-	uint16_t	pgmilc;			/* 0x00cc */
-	uint16_t	iprcc;			/* 0x00ce */
-	uint32_t	dxc;			/* 0x00d0 */
-	uint16_t	mcn;			/* 0x00d4 */
-	uint8_t		perc;			/* 0x00d6 */
-	uint8_t		peratmid;		/* 0x00d7 */
-	uint64_t	peraddr;		/* 0x00d8 */
-	uint8_t		eai;			/* 0x00e0 */
-	uint8_t		peraid;			/* 0x00e1 */
-	uint8_t		oai;			/* 0x00e2 */
-	uint8_t		armid;			/* 0x00e3 */
-	uint8_t		reservede4[4];		/* 0x00e4 */
-	uint64_t	tecmc;			/* 0x00e8 */
-	uint8_t		reservedf0[12];		/* 0x00f0 */
-#define CRYCB_FORMAT_MASK 0x00000003
-#define CRYCB_FORMAT0 0x00000000
-#define CRYCB_FORMAT1 0x00000001
-#define CRYCB_FORMAT2 0x00000003
-	uint32_t	crycbd;			/* 0x00fc */
-	uint64_t	gcr[16];		/* 0x0100 */
-	union {
-		uint64_t	gbea;			/* 0x0180 */
-		uint64_t	sidad;
-	};
-	uint8_t		reserved188[8];		/* 0x0188 */
-	uint64_t   	sdnxo;			/* 0x0190 */
-	uint8_t    	reserved198[8];		/* 0x0198 */
-	uint32_t	fac;			/* 0x01a0 */
-	uint8_t		reserved1a4[20];	/* 0x01a4 */
-	uint64_t	cbrlo;			/* 0x01b8 */
-	uint8_t		reserved1c0[8];		/* 0x01c0 */
-#define ECD_HOSTREGMGMT	0x20000000
-#define ECD_MEF		0x08000000
-#define ECD_ETOKENF	0x02000000
-#define ECD_ECC		0x00200000
-	uint32_t	ecd;			/* 0x01c8 */
-	uint8_t		reserved1cc[18];	/* 0x01cc */
-	uint64_t	pp;			/* 0x01de */
-	uint8_t		reserved1e6[2];		/* 0x01e6 */
-	uint64_t	itdba;			/* 0x01e8 */
-	uint64_t   	riccbd;			/* 0x01f0 */
-	uint64_t	gvrd;			/* 0x01f8 */
-	uint64_t	reserved200[48];	/* 0x0200 */
-	uint64_t	pv_grregs[16];		/* 0x0380 */
-} __attribute__((packed));
-
-union esca_sigp_ctrl {
-	uint16_t value;
-	struct {
-		uint8_t c : 1;
-		uint8_t reserved: 7;
-		uint8_t scn;
-	};
-};
-
-struct esca_entry {
-	union esca_sigp_ctrl sigp_ctrl;
-	uint16_t   reserved1[3];
-	uint64_t   sda;
-	uint64_t   reserved2[6];
-};
-
-union ipte_control {
-	unsigned long val;
-	struct {
-		unsigned long k  : 1;
-		unsigned long kh : 31;
-		unsigned long kg : 32;
-	};
-};
-
-struct esca_block {
-	union ipte_control ipte_control;
-	uint64_t   reserved1[7];
-	uint64_t   mcn[4];
-	uint64_t   reserved2[20];
-	struct esca_entry cpu[256];
-};
+#include <asm/sie-arch.h>
 
 struct vm_uv {
 	uint64_t vm_handle;
-- 
2.43.0


