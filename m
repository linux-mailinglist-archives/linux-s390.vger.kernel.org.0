Return-Path: <linux-s390+bounces-20610-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vm4hBsUGJ2qiqQIAu9opvQ
	(envelope-from <linux-s390+bounces-20610-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 08 Jun 2026 20:15:33 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1458C659992
	for <lists+linux-s390@lfdr.de>; Mon, 08 Jun 2026 20:15:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=tX5WhTNW;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20610-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-20610-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1039130013A8
	for <lists+linux-s390@lfdr.de>; Mon,  8 Jun 2026 18:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529C03D9043;
	Mon,  8 Jun 2026 18:15:22 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D83D8903;
	Mon,  8 Jun 2026 18:15:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942522; cv=none; b=R0fCPZ+mPNez0L4oGraEyPIZQQWqpuY99LidYeG/qDzMK1YgrLPNRB3xbuUctZNcGCjg11ltjYYkEpIQQ2rJsX8Qn/eJP11I2YnYrZ/i6+k4wdWwXAyUOSBZTj3ZfgxRRRkEXUGOiQhdvz/dNU8pZmmbGcAvRE6LYdHdhPVHkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942522; c=relaxed/simple;
	bh=jyeHStup7bcEmb7YwAA0o4q5Cd8HPAT7sGtOIZLjuUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAXEB6+b77+Di6MV+DB9ecsGrVMNy6lVD6bkIB3FNnK5xzRe6J6u1LlI5ztGNIdiqv+06xpTIHaO0ADyjZvtwdadbHUmHxybagZRfjJsY+LWv/mS9I6Azxt+di+GoMVBub/PJrNoXDfZ6yeSyF/fMJ40P6vBvBDtEsKRwVf/jkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tX5WhTNW; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6588W7Fo3088318;
	Mon, 8 Jun 2026 18:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Els+tXHkKesJ5A7Q0
	3cP5o0dgLZBH8RfYyS9Xyv9G78=; b=tX5WhTNWZSb6tH+MVn7Ca1GGw2EaBU9cm
	LLeHVnEVra1ahjXDyKUeHucZ2pKBr1m27noMFi98rz5bPNZR6NbiWasYMbb0yUj6
	yaOj+PNTDDH8G3YVe98r2FZ+bbhcZBKSCn1IuYvp2knVUBcrN5dFa6Ee6Cf+yJ2y
	OOA4V38Ta40/zBQm+oVi50iuB2X+R0gNCpw7gbt99/zBoJ973S8ESQdrA19GKnri
	xU9+Z4UPJfXSUbmXZa1G/dMRY+AEWvKamNaR0w1iYTYfK/6hZZxeXLgJkE8zE5vF
	VmIDxeBZ9svhWlO3IT3J3Bi7IK4LeE8KzODfHT+aCCiKcdJf+SXvw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhrt2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:15:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658I4cFZ003171;
	Mon, 8 Jun 2026 18:15:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycgxfj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:15:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658IEwIi60227912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 18:14:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 786CE20040;
	Mon,  8 Jun 2026 18:14:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32EA12004B;
	Mon,  8 Jun 2026 18:14:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 18:14:58 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        japo@linux.ibm.com (Jan Polensky)
Subject: [PATCH v6 6/6] s390: Enable Rust support
Date: Mon,  8 Jun 2026 20:14:51 +0200
Message-ID: <20260608181451.3734956-7-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608181451.3734956-1-japo@linux.ibm.com>
References: <20260608181451.3734956-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3MCBTYWx0ZWRfX63vCQEFAnmEg
 AZELY2MZEHhdbZR6KG8YIRvcJy8idf/xpurSh1sMUlPAmiHbM+xU2WOiyMeFTUT4d0NMqrQVgue
 9P24JTtsH+jzOVHu9aRUd/QToIaCTddMIHFqsS6EvzFi14KaBFY1RFj8FobPZm0RwllZkDSoc11
 /GZJxcWjaX17n06qIRmKhKoVNNNQ1C1DfWemJncVr8ReJabjLjYZR6wsTlQnOrRcgZizfzvqVVb
 yKDh7vNc38gvc/lIDNAopdOLy9MT9XmVLUee1h3GQot9y2wj4W79vVqyKw0e69zaPxgMMiPydvr
 E/i4wM0EKyjMDYRNFLzozwpDtqB9WFta0L79KWIK+19Gw6y83pTvWYmgdcjgyT28XPtTouVWp7h
 amuxioVnvQRnwmvEVv3bfO3zbeiN76L19lIZsAzpFipGBXpmnIV5hchA/Qix0Gtp3uO4pe4nzim
 JRd8vqu3iaC6OrP5xFg==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a2706a7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dVHDsLM4Y7J7NbvvS_QA:9
X-Proofpoint-ORIG-GUID: IiK5sZPCHTg8LOOofaoFjUCOYUPKr_eG
X-Proofpoint-GUID: lxrPJhgAzmqQsAFruuXIe09uHvTxRb5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080170
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:ojeda@kernel.org,m:peterz@infradead.org,m:jpoimboe@kernel.org,m:jbaron@akamai.com,m:aliceryhl@google.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:dakr@kernel.org,m:rostedt@goodmis.org,m:ardb@kernel.org,m:linux-s390@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:japo@linux.ibm.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,garyguo.net,protonmail.com,umich.edu,goodmis.org,vger.kernel.org];
	FORGED_SENDER(0.00)[japo@linux.ibm.com,linux-s390@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20610-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[japo@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1458C659992

Enable building Rust code on s390 by wiring the architecture into the
kernel Rust infrastructure.

Add s390 to the Rust arch support documentation, provide the s390 Rust
target and required compiler flags, and set the bindgen target for
arch/s390. Adjust the Rust target generation and minimum rustc version
gating so the s390 setup is handled explicitly.

The Rust toolchain uses the "s390x" triple naming for the 64 bit target.

Rust support is currently incompatible with CONFIG_EXPOLINE, which
relies on compiler support for the -mindirect-branch= and
-mfunction_return= options. Therefore, select HAVE_RUST only when
EXPOLINE is disabled.

Acked-by: Miguel Ojeda <ojeda@kernel.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 Documentation/rust/arch-support.rst |  1 +
 arch/s390/Kconfig                   |  1 +
 arch/s390/Makefile                  | 28 +++++++++++++++++-----------
 rust/Makefile                       |  1 +
 scripts/generate_rust_target.rs     |  2 ++
 scripts/min-tool-version.sh         |  6 +++++-
 6 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index 6e6a515d0899..4f980815e92a 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -19,6 +19,7 @@ Architecture   Level of support  Constraints
 ``arm64``      Maintained        Little Endian only.
 ``loongarch``  Maintained        \-
 ``riscv``      Maintained        ``riscv64`` and LLVM/Clang only.
+``s390``       Maintained        ``CONFIG_EXPOLINE`` must be disabled.
 ``um``         Maintained        \-
 ``x86``        Maintained        ``x86_64`` only.
 =============  ================  ==============================================
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ecbcbb781e40..26951781d74d 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -248,6 +248,7 @@ config S390
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RETHOOK
 	select HAVE_RSEQ
+	select HAVE_RUST if !EXPOLINE
 	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_SETUP_PER_CPU_AREA
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 297976b41088..8b712cd85fcd 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -35,25 +35,31 @@ KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_CC_NO_ARRAY_BOUNDS),-Wno-array-bounds)
 
+KBUILD_RUSTFLAGS += --target=s390x-unknown-none-softfloat -Zpacked-stack -Ctarget-feature=+backchain
+
 UTS_MACHINE	:= s390x
 STACK_SIZE	:= $(if $(CONFIG_KASAN),65536,$(if $(CONFIG_KMSAN),65536,16384))
 CHECKFLAGS	+= -D__s390__ -D__s390x__
 
 export LD_BFD
 
-mflags-$(CONFIG_MARCH_Z10)    := -march=z10
-mflags-$(CONFIG_MARCH_Z196)   := -march=z196
-mflags-$(CONFIG_MARCH_ZEC12)  := -march=zEC12
-mflags-$(CONFIG_MARCH_Z13)    := -march=z13
-mflags-$(CONFIG_MARCH_Z14)    := -march=z14
-mflags-$(CONFIG_MARCH_Z15)    := -march=z15
-mflags-$(CONFIG_MARCH_Z16)    := -march=z16
-mflags-$(CONFIG_MARCH_Z17)    := -march=z17
+march-name-$(CONFIG_MARCH_Z10)   := z10
+march-name-$(CONFIG_MARCH_Z196)  := z196
+march-name-$(CONFIG_MARCH_ZEC12) := zEC12
+march-name-$(CONFIG_MARCH_Z13)   := z13
+march-name-$(CONFIG_MARCH_Z14)   := z14
+march-name-$(CONFIG_MARCH_Z15)   := z15
+march-name-$(CONFIG_MARCH_Z16)   := z16
+march-name-$(CONFIG_MARCH_Z17)   := z17
 
-export CC_FLAGS_MARCH := $(mflags-y)
+mflags := -march=$(march-name-y)
 
-aflags-y += $(mflags-y)
-cflags-y += $(mflags-y)
+export CC_FLAGS_MARCH := $(mflags)
+
+aflags-y += $(mflags)
+cflags-y += $(mflags)
+
+KBUILD_RUSTFLAGS += -Ctarget-cpu=$(march-name-y)
 
 cflags-$(CONFIG_MARCH_Z10_TUNE)		+= -mtune=z10
 cflags-$(CONFIG_MARCH_Z196_TUNE)	+= -mtune=z196
diff --git a/rust/Makefile b/rust/Makefile
index b9e9f512cec3..77460502f576 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -403,6 +403,7 @@ BINDGEN_TARGET_x86	:= x86_64-linux-gnu
 BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
 BINDGEN_TARGET_arm	:= arm-linux-gnueabi
 BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
+BINDGEN_TARGET_s390	:= s390x-linux-gnu
 # This is only for i386 UM builds, which need the 32-bit target not -m32
 BINDGEN_TARGET_i386	:= i386-linux-gnu
 BINDGEN_TARGET_um	:= $(BINDGEN_TARGET_$(SUBARCH))
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 16f7e855e012..3bf296581a88 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -260,6 +260,8 @@ fn main() {
         }
     } else if cfg.has("LOONGARCH") {
         panic!("loongarch uses the builtin rustc loongarch64-unknown-none-softfloat target");
+    } else if cfg.has("S390") {
+        panic!("s390 uses the builtin rustc s390x-unknown-none-softfloat target");
     } else {
         panic!("Unsupported architecture");
     }
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index b96ec2d379b6..296acf8f71aa 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -31,7 +31,11 @@ llvm)
 	fi
 	;;
 rustc)
-	echo 1.85.0
+	if [ "$SRCARCH" = "s390" ]; then
+		echo 1.96.0
+	else
+		echo 1.85.0
+	fi
 	;;
 bindgen)
 	echo 0.71.1
-- 
2.53.0


