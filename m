Return-Path: <linux-s390+bounces-8554-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBB8A193BA
	for <lists+linux-s390@lfdr.de>; Wed, 22 Jan 2025 15:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE9777A4DF0
	for <lists+linux-s390@lfdr.de>; Wed, 22 Jan 2025 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576A7213E90;
	Wed, 22 Jan 2025 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYLH4cWs"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB9212FA9
	for <linux-s390@vger.kernel.org>; Wed, 22 Jan 2025 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555543; cv=none; b=pS3Wln6p1Nwg698PL3s6U+HwCUiqOvmazM4ebxOKQKqhF3xjNddUM2DNkqV3ptpvxuq82ZhOOW08kHtMkvYkNG3DZ0KADtul8nMEVlPIqTzB5dPqk+XQINtLPvnizds5b+oIaixODosFQ6VUHIGT3z5+nEDBE7NMPeWLHF3v9qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555543; c=relaxed/simple;
	bh=OW8l9b0mWMibxL7S+zZKAkfNNZF4AGm1COlshvpuAls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TxCLy/zjtE4qse6adPHFcSK1DHsPZOklIE/fYwaFRegWewjHMfft0K8wUr0HHDlxYNLvAphv5qoJTSHf3YNoPMtZpm7UNvrYEFg+Uy79HfsJYQiIoTNZW3/A2LgBdDwdSv4lA2d3B80J2Psdf+zdb/xRRUsIKcJOn1SjiYBeAhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYLH4cWs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737555539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4jam8hZHhAr5tH3Ta3PwiMkyp6qmiOo/rLF5JeX+p9I=;
	b=BYLH4cWsKx5Y3l2nmtUgkRLf3im0Ns+GmFBu19+ItN2cucmFAfjUEl1wfF8TyRZgQptM5U
	CDtW90k6jQF3R4xQEACDWetqNmVl7Q6GbETLpz5fPVZo7+9JxC8DHma+oLZz7hpvCjjryy
	0h6KW7kf9K51NkUNLoXSyTUWKNNIVa4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-k5yISiUYM-ukZ3O2ikEoXQ-1; Wed, 22 Jan 2025 09:18:57 -0500
X-MC-Unique: k5yISiUYM-ukZ3O2ikEoXQ-1
X-Mimecast-MFC-AGG-ID: k5yISiUYM-ukZ3O2ikEoXQ
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d0b5036394so10044507a12.3
        for <linux-s390@vger.kernel.org>; Wed, 22 Jan 2025 06:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737555536; x=1738160336;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jam8hZHhAr5tH3Ta3PwiMkyp6qmiOo/rLF5JeX+p9I=;
        b=WgXP4pDXRVo6jrXO1m9vfqr3KBtr8PZA1TmUvhlY78rCwpAaibJOlB/L8FCt8e1I8Y
         3cWXzuRa8PXgFWu8rHJFtTMLYuw28BY9EgB1kx7ocmZdeY3ekCu6M0Q380yT2o2oOHA1
         wPvHNvgKKA4jf4/tpBXJ8TJjxjuUSzEBGawEfrai/spmGMLNrECovKKuKTSC1lhjMzFc
         7CkCfDMkPEbUZbc2AKHZhvUi59rnvhyHxGAI7rxsy6YMWeD7VXSc0lBAaNH8s0wGbiqg
         fTS+vfHWZk4RlVgcLT7bN8L8U9Mq1n3kMdZXyiJEdDSw1U2A835UkqHGHwHkYnPwXTUU
         Tlbw==
X-Forwarded-Encrypted: i=1; AJvYcCWaLxa8fEu4cqQee8W6NTBB/khv9uvqatv39I98wiDIDEOH7LnmuGjQn3rlNkPo7kKccXBDh6LCgFdR@vger.kernel.org
X-Gm-Message-State: AOJu0YzxBlP1XtiKGZXeupZpu1J6/MD0TVI/huX26k+rJ3uW4tnrlTop
	TCAnT/c7LsslTZJmmUhVAziJ+TVp9QCexoHT3Vm2sgWnUreOCnxFNGFDRXwqtlnEPqETIOghpGe
	rLvQ+kazaPs9IsnOCQ5M5GFKguITmpWBJUrE28vK3n/KsvuiTzvOlLQKrjA==
X-Gm-Gg: ASbGnctOGvIUCnjZNPgSyxkAAqmmytdC7LrevmYr5RWItjxImWOXn7Yl/ILPBVVw0dh
	bqr7NfvFKGPe1fnyfYYKNMVXqXr+qMiq8+vaW8FDWA5u/pykfrC6lElxJlidjtukhww8H8PPNlv
	SGGTzglBGrPIqSmn5KEplgFzV6/4UrcS0gW3/chilDAl8CHYZJoEWCtMVmYEyzeAbXsF5CiRTBi
	yxp2O4MVhp7VPUYN5omGrdvz6Ai2NEVSfDNfz1R07PXNhqoRdrnz5433MdYQCPgsY8dy3IME9q3
	sh+gsVOrLs0TXwkpygTK
X-Received: by 2002:a05:6402:4306:b0:5d0:e570:508d with SMTP id 4fb4d7f45d1cf-5db7d2fe766mr23190050a12.17.1737555536314;
        Wed, 22 Jan 2025 06:18:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrjzTVk+6pPpvBqAW2a2tTL9E9+rGcQkPlSJlbq34xQPE871CwG7ULmkCPSG7p5HVhxbYDhw==
X-Received: by 2002:a05:6402:4306:b0:5d0:e570:508d with SMTP id 4fb4d7f45d1cf-5db7d2fe766mr23190004a12.17.1737555535872;
        Wed, 22 Jan 2025 06:18:55 -0800 (PST)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73eb5b83sm8645690a12.49.2025.01.22.06.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 06:18:53 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Wed, 22 Jan 2025 15:18:34 +0100
Subject: [PATCH v2] fs: introduce getfsxattrat and setfsxattrat syscalls
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-xattrat-syscall-v2-1-5b360d4fbcb2@kernel.org>
X-B4-Tracking: v=1; b=H4sIADn+kGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDQ0MT3YrEkpKixBLd4sri5MScHF2zRENDY7MUo5QkU0sloK6CotS0zAq
 widGxtbUAeKMm0mEAAAA=
X-Change-ID: 20250114-xattrat-syscall-6a1136d2db59
To: linux-m68k@lists.linux-m68k.org, tglx@linutronix.de, jcmvbkbc@gmail.com, 
 linux-security-module@vger.kernel.org, arnd@arndb.de, 
 linux-fsdevel@vger.kernel.org, chris@zankel.net, npiggin@gmail.com, 
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, luto@kernel.org, 
 jack@suse.cz, brauner@kernel.org, monstr@monstr.eu, 
 linux-arch@vger.kernel.org, mingo@redhat.com, linux-alpha@vger.kernel.org, 
 christophe.leroy@csgroup.eu, linux-sh@vger.kernel.org, 
 linux-parisc@vger.kernel.org, naveen@kernel.org, bp@alien8.de, 
 hpa@zytor.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 x86@kernel.org, maddy@linux.ibm.com, dave.hansen@linux.intel.com, 
 viro@zeniv.linux.org.uk, linux-s390@vger.kernel.org, 
 linux-api@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>, linux-xfs@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17868; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=FUCziKETb1u8jwYVTb3dolFzf/q0mt6kXfajdZEjZi8=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIY0if88054LdEX56y8a1Z737bLX+60zMrM2FWnr8tW2
 J2+Vc1m8qWOUhYGMS4GWTFFlnXSWlOTiqTyjxjUyMPMYWUCGcLAxSkAE7mXyMgw5/vXadLZCUFx
 z+XYfKonWFd9thR9aran4cWqLgeeY0dfMPyPjNMNu9nd1Sj7g8U7zCiyxXuCWcz17Xe6lpbvtDI
 Te80PALkaSFU=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
extended attributes/flags. The syscalls take parent directory FD and
path to the child together with struct fsxattr.

This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
that file don't need to be open. By having this we can manipulated
inode extended attributes not only on normal files but also on
special ones. This is not possible with FS_IOC_FSSETXATTR ioctl as
opening special files returns VFS special inode instead of
underlying filesystem one.

This patch adds two new syscalls which allows userspace to set
extended inode attributes on special files by using parent directory
to open FS inode.

Also, as vfs_fileattr_set() is now will be called on special files
too, let's forbid any other attributes except projid and nextents
(symlink can have an extent).

CC: linux-api@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org
CC: linux-xfs@vger.kernel.org
Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
v1:
https://lore.kernel.org/linuxppc-dev/20250109174540.893098-1-aalbersh@kernel.org/

Previous discussion:
https://lore.kernel.org/linux-xfs/20240520164624.665269-2-aalbersh@redhat.com/

XFS has project quotas which could be attached to a directory. All
new inodes in these directories inherit project ID set on parent
directory.

The project is created from userspace by opening and calling
FS_IOC_FSSETXATTR on each inode. This is not possible for special
files such as FIFO, SOCK, BLK etc. Therefore, some inodes are left
with empty project ID. Those inodes then are not shown in the quota
accounting but still exist in the directory. Moreover, in the case
when special files are created in the directory with already
existing project quota, these inode inherit extended attributes.
This than leaves them with these attributes without the possibility
to clear them out. This, in turn, prevents userspace from
re-creating quota project on these existing files.
---
 arch/alpha/kernel/syscalls/syscall.tbl      |  2 +
 arch/arm/tools/syscall.tbl                  |  2 +
 arch/arm64/tools/syscall_32.tbl             |  2 +
 arch/m68k/kernel/syscalls/syscall.tbl       |  2 +
 arch/microblaze/kernel/syscalls/syscall.tbl |  2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  2 +
 arch/parisc/kernel/syscalls/syscall.tbl     |  2 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  2 +
 arch/s390/kernel/syscalls/syscall.tbl       |  2 +
 arch/sh/kernel/syscalls/syscall.tbl         |  2 +
 arch/sparc/kernel/syscalls/syscall.tbl      |  2 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  2 +
 arch/x86/entry/syscalls/syscall_64.tbl      |  2 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |  2 +
 fs/inode.c                                  | 99 +++++++++++++++++++++++++++++
 fs/ioctl.c                                  | 16 ++++-
 include/linux/fileattr.h                    |  1 +
 include/linux/syscalls.h                    |  4 ++
 include/uapi/asm-generic/unistd.h           |  8 ++-
 21 files changed, 157 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index c59d53d6d3f3490f976ca179ddfe02e69265ae4d..4b9e687494c16b60c6fd6ca1dc4d6564706a7e25 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -506,3 +506,5 @@
 574	common	getxattrat			sys_getxattrat
 575	common	listxattrat			sys_listxattrat
 576	common	removexattrat			sys_removexattrat
+577	common	getfsxattrat			sys_getfsxattrat
+578	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 49eeb2ad8dbd8e074c6240417693f23fb328afa8..66466257f3c2debb3e2299f0b608c6740c98cab2 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -481,3 +481,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
index 69a829912a05eb8a3e21ed701d1030e31c0148bc..9c516118b154811d8d11d5696f32817430320dbf 100644
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -478,3 +478,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index f5ed71f1910d09769c845c2d062d99ee0449437c..159476387f394a92ee5e29db89b118c630372db2 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -466,3 +466,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 680f568b77f2cbefc3eacb2517f276041f229b1e..a6d59ee740b58cacf823702003cf9bad17c0d3b7 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -472,3 +472,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 0b9b7e25b69ad592642f8533bee9ccfe95ce9626..cfe38fcebe1a0279e11751378d3e71c5ec6b6569 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -405,3 +405,5 @@
 464	n32	getxattrat			sys_getxattrat
 465	n32	listxattrat			sys_listxattrat
 466	n32	removexattrat			sys_removexattrat
+467	n32	getfsxattrat			sys_getfsxattrat
+468	n32	setfsxattrat			sys_setfsxattrat
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index c844cd5cda620b2809a397cdd6f4315ab6a1bfe2..29a0c5974d1aa2f01e33edc0252d75fb97abe230 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -381,3 +381,5 @@
 464	n64	getxattrat			sys_getxattrat
 465	n64	listxattrat			sys_listxattrat
 466	n64	removexattrat			sys_removexattrat
+467	n64	getfsxattrat			sys_getfsxattrat
+468	n64	setfsxattrat			sys_setfsxattrat
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 349b8aad1159f404103bd2057a1e64e9bf309f18..6c00436807c57c492ba957fcd59af1202231cf80 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -454,3 +454,5 @@
 464	o32	getxattrat			sys_getxattrat
 465	o32	listxattrat			sys_listxattrat
 466	o32	removexattrat			sys_removexattrat
+467	o32	getfsxattrat			sys_getfsxattrat
+468	o32	setfsxattrat			sys_setfsxattrat
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index d9fc94c869657fcfbd7aca1d5f5abc9fae2fb9d8..b3578fac43d6b65167787fcc97d2d09f5a9828e7 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -465,3 +465,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index d8b4ab78bef076bd50d49b87dea5060fd8c1686a..808045d82c9465c3bfa96b15947546efe5851e9a 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -557,3 +557,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index e9115b4d8b635b846e5c9ad6ce229605323723a5..78dfc2c184d4815baf8a9e61c546c9936d58a47c 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -469,3 +469,5 @@
 464  common	getxattrat		sys_getxattrat			sys_getxattrat
 465  common	listxattrat		sys_listxattrat			sys_listxattrat
 466  common	removexattrat		sys_removexattrat		sys_removexattrat
+467  common	getfsxattrat		sys_getfsxattrat		sys_getfsxattrat
+468  common	setfsxattrat		sys_setfsxattrat		sys_setfsxattrat
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index c8cad33bf250ea110de37bd1407f5a43ec5e38f2..d5a5c8339f0ed25ea07c4aba90351d352033c8a0 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -470,3 +470,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 727f99d333b304b3db0711953a3d91ece18a28eb..817dcd8603bcbffc47f3f59aa3b74b16486453d0 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -512,3 +512,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4d0fb2fba7e208ae9455459afe11e277321d9f74..b4842c027c5d00c0236b2ba89387c5e2267447bd 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -472,3 +472,5 @@
 464	i386	getxattrat		sys_getxattrat
 465	i386	listxattrat		sys_listxattrat
 466	i386	removexattrat		sys_removexattrat
+467	i386	getfsxattrat		sys_getfsxattrat
+468	i386	setfsxattrat		sys_setfsxattrat
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 5eb708bff1c791debd6cfc5322583b2ae53f6437..b6f0a7236aaee624cf9b484239a1068085a8ffe1 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -390,6 +390,8 @@
 464	common	getxattrat		sys_getxattrat
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
+467	common	getfsxattrat		sys_getfsxattrat
+468	common	setfsxattrat		sys_setfsxattrat
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 37effc1b134eea061f2c350c1d68b4436b65a4dd..425d56be337d1de22f205ac503df61ff86224fee 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -437,3 +437,5 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	getfsxattrat			sys_getfsxattrat
+468	common	setfsxattrat			sys_setfsxattrat
diff --git a/fs/inode.c b/fs/inode.c
index 6b4c77268fc0ecace4ac78a9ca777fbffc277f4a..cdecb793b2ab5ab01e2333da4382919b94c7f65f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -23,6 +23,9 @@
 #include <linux/rw_hint.h>
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
+#include <linux/syscalls.h>
+#include <linux/fileattr.h>
+#include <linux/namei.h>
 #include <trace/events/writeback.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/timestamp.h>
@@ -2953,3 +2956,99 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
 	return mode & ~S_ISGID;
 }
 EXPORT_SYMBOL(mode_strip_sgid);
+
+SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
+		struct fsxattr __user *, fsx, unsigned int, at_flags)
+{
+	struct fd dir;
+	struct fileattr fa;
+	struct path filepath;
+	int error;
+	unsigned int lookup_flags = 0;
+
+	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+
+	if (at_flags & AT_SYMLINK_FOLLOW)
+		lookup_flags |= LOOKUP_FOLLOW;
+
+	if (at_flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
+	dir = fdget(dfd);
+	if (!fd_file(dir))
+		return -EBADF;
+
+	if (!S_ISDIR(file_inode(fd_file(dir))->i_mode)) {
+		error = -EBADF;
+		goto out;
+	}
+
+	error = user_path_at(dfd, filename, lookup_flags, &filepath);
+	if (error)
+		goto out;
+
+	error = vfs_fileattr_get(filepath.dentry, &fa);
+	if (error)
+		goto out_path;
+
+	if (copy_fsxattr_to_user(&fa, fsx))
+		error = -EFAULT;
+
+out_path:
+	path_put(&filepath);
+out:
+	fdput(dir);
+	return error;
+}
+
+SYSCALL_DEFINE4(setfsxattrat, int, dfd, const char __user *, filename,
+		struct fsxattr __user *, fsx, unsigned int, at_flags)
+{
+	struct fd dir;
+	struct fileattr fa;
+	struct path filepath;
+	int error;
+	unsigned int lookup_flags = 0;
+
+	if ((at_flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+
+	if (at_flags & AT_SYMLINK_FOLLOW)
+		lookup_flags |= LOOKUP_FOLLOW;
+
+	if (at_flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
+	dir = fdget(dfd);
+	if (!fd_file(dir))
+		return -EBADF;
+
+	if (!S_ISDIR(file_inode(fd_file(dir))->i_mode)) {
+		error = -EBADF;
+		goto out;
+	}
+
+	if (copy_fsxattr_from_user(&fa, fsx)) {
+		error = -EFAULT;
+		goto out;
+	}
+
+	error = user_path_at(dfd, filename, lookup_flags, &filepath);
+	if (error)
+		goto out;
+
+	error = mnt_want_write(filepath.mnt);
+	if (error)
+		goto out_path;
+
+	error = vfs_fileattr_set(file_mnt_idmap(fd_file(dir)), filepath.dentry,
+				 &fa);
+	mnt_drop_write(filepath.mnt);
+
+out_path:
+	path_put(&filepath);
+out:
+	fdput(dir);
+	return error;
+}
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 638a36be31c14afc66a7fd6eb237d9545e8ad997..dc160c2ef145e4931d625f1f93c2a8ae7f87abf3 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -558,8 +558,7 @@ int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
 }
 EXPORT_SYMBOL(copy_fsxattr_to_user);
 
-static int copy_fsxattr_from_user(struct fileattr *fa,
-				  struct fsxattr __user *ufa)
+int copy_fsxattr_from_user(struct fileattr *fa, struct fsxattr __user *ufa)
 {
 	struct fsxattr xfa;
 
@@ -646,6 +645,19 @@ static int fileattr_set_prepare(struct inode *inode,
 	if (fa->fsx_cowextsize == 0)
 		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
 
+	/*
+	 * The only use case for special files is to set project ID, forbid any
+	 * other attributes
+	 */
+	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
+		if (fa->fsx_xflags & ~FS_XFLAG_PROJINHERIT)
+			return -EINVAL;
+		if (!S_ISLNK(inode->i_mode) && fa->fsx_nextents)
+			return -EINVAL;
+		if (fa->fsx_extsize || fa->fsx_cowextsize)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 47c05a9851d0600964b644c9c7218faacfd865f8..8598e94b530b8b280a2697eaf918dd60f573d6ee 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -34,6 +34,7 @@ struct fileattr {
 };
 
 int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa);
+int copy_fsxattr_from_user(struct fileattr *fa, struct fsxattr __user *ufa);
 
 void fileattr_fill_xflags(struct fileattr *fa, u32 xflags);
 void fileattr_fill_flags(struct fileattr *fa, u32 flags);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index c6333204d45130eb022f6db460eea34a1f6e91db..3134d463d9af64c6e78adb37bff4b91f77b5305f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -371,6 +371,10 @@ asmlinkage long sys_removexattrat(int dfd, const char __user *path,
 asmlinkage long sys_lremovexattr(const char __user *path,
 				 const char __user *name);
 asmlinkage long sys_fremovexattr(int fd, const char __user *name);
+asmlinkage long sys_getfsxattrat(int dfd, const char __user *filename,
+				 struct fsxattr *fsx, unsigned int at_flags);
+asmlinkage long sys_setfsxattrat(int dfd, const char __user *filename,
+				 struct fsxattr *fsx, unsigned int at_flags);
 asmlinkage long sys_getcwd(char __user *buf, unsigned long size);
 asmlinkage long sys_eventfd2(unsigned int count, int flags);
 asmlinkage long sys_epoll_create1(int flags);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 88dc393c2bca38c0fa1b3fae579f7cfe4931223c..50be2e1007bc2779120d05c6e9512a689f86779c 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -850,8 +850,14 @@ __SYSCALL(__NR_listxattrat, sys_listxattrat)
 #define __NR_removexattrat 466
 __SYSCALL(__NR_removexattrat, sys_removexattrat)
 
+/* fs/inode.c */
+#define __NR_getfsxattrat 467
+__SYSCALL(__NR_getfsxattrat, sys_getfsxattrat)
+#define __NR_setfsxattrat 468
+__SYSCALL(__NR_setfsxattrat, sys_setfsxattrat)
+
 #undef __NR_syscalls
-#define __NR_syscalls 467
+#define __NR_syscalls 469
 
 /*
  * 32 bit systems traditionally used different

---
base-commit: 4c538044ee2d11299cc57ac1e92d343e1e83b847
change-id: 20250114-xattrat-syscall-6a1136d2db59

Best regards,
-- 
Andrey Albershteyn <aalbersh@kernel.org>


