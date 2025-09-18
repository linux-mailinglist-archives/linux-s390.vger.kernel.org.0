Return-Path: <linux-s390+bounces-13088-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CEBB55B32
	for <lists+linux-s390@lfdr.de>; Sat, 13 Sep 2025 02:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A0B1CC6D94
	for <lists+linux-s390@lfdr.de>; Sat, 13 Sep 2025 00:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9516A14A60C;
	Sat, 13 Sep 2025 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOStwEqH"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BEB7081C
	for <linux-s390@vger.kernel.org>; Sat, 13 Sep 2025 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724334; cv=none; b=JfcGrfbZimfBOdRh17ahkjODloBmra6zjkyLixhjccA/JVDHaygNHH2e36kf1lIDVapbWb/I3XbqShY1aZubgIwlAKodDEgJIexc8kY+pQpQ+d/CE8yo1gcy5iN/fl0jZHLXAOtTGMZEhGU8ehJJ+PEjuY0nz5igRdBfRJuTco4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724334; c=relaxed/simple;
	bh=kibOCauDCBkqzoIIQtVCNE2P0zxtFVdI1DUZ/kvaArs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9Qn67T0AwEDGVqPamE6XylKVhGOvaFYPq5iQyMdl3p5HObXgJyziPz74kyRqjF058e7hqcTJE1hlxQ+TnR8riNTk0c+IDfIwfpET8ays0IZnR4z1nd6eicPuVA++y4uREVMq0kQl9dGqp507xtC5BRZI9GlF7pEkB0QyxWUWng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOStwEqH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b043a33b060so374069966b.1
        for <linux-s390@vger.kernel.org>; Fri, 12 Sep 2025 17:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724329; x=1758329129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi1FJKwP9nWnSjptSGh11GRsqwR1G48l7l6Ou3g4XAs=;
        b=HOStwEqHw8VoYhk7VlxxKOyJSgS3oHdg9X+fH9tPx8w3h+SQEBbgO6RjhW40LGfh7U
         7bxuSSZ2f0QLvSJJrCAbrfcXm6EhsCN+XJ1lIzoOPCQOiLb7LqDSXQQYP85D5gX0T6+P
         5jaIBw0hoLHPtpGJ3pWXXPg3JAdrjiLpKOHlOvGYo45xN0DLGaejUxVIxRQI3oZIpRud
         hvko6/1Vpn1tmc/uXidMtUD0wPWKYEVLP0V5MxpbQDXGGQJF2b6NB0mbAzuvb8tbGKZa
         R+mcO//zHtUaf0W7Fc3IPPmoFcBAZCBNm7+Oa1SPvpA5yHNZZM9b7qS1xXWTaim6mZiS
         9M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724329; x=1758329129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi1FJKwP9nWnSjptSGh11GRsqwR1G48l7l6Ou3g4XAs=;
        b=K+tVRuayXXpbMDa65Cz0CenGbBIRK6d+wd2bZ2an1vKJO0IQ94SfjNVjtPwrGJp/3Z
         G2NOimXf0GtKW+noqAeDYNv6Af7vMIOF5rFiJMSlyU2BXgQLpIJBnMNKiKG3+UTMgNeZ
         9HxN8ilkfmsWqUBNwUeA6ZmMhbvBAHfchNRa/oFCV0+KKJGdCiXiZ9t6frWL3mH49Rmw
         1RN9WX1BDiK3MOocPa+zvr1v5rvKyeuP/vGrqUOlFi9KjbSox4NNM8ov9xgR+S2Q2DTk
         ivhMk0Ebma6BGuir9zAKWUt8x9gQ0jdDA1G8XC50tIw0X9uMw0ewkTFyNR50Nbj9fi5L
         d0fg==
X-Forwarded-Encrypted: i=1; AJvYcCV1gOQp3VtKxnxucdWDHMqzrqsB7MaYW7pyltguiqBlSqXJ//y6xP5Ny7Ti5BxSHORc7zCAFKviJuI8@vger.kernel.org
X-Gm-Message-State: AOJu0YzM4DYcyCG83rqVVvMMlmonICOL7MPQ+u/QZ3qMKeS5jarvZ1CH
	xHdj0dJotFraxQEPYz0k5cRMTMvrRAaUaoGXJBZJ+dM4Q6DBbrXi0M2m
X-Gm-Gg: ASbGncscOyRM4fyJTx/pOX2G5FLaj5bawZ8RVwDqAHa4X9UX+yKxa+inqTezoYH3kUL
	NTkMB38Q1wwEhoBavGjlei7DBIVcYhU2/pwT5Q8HyUQzeGYWmK16sDieZYnZVSdfDJ6dM987f/7
	QsL/0jQ9anbMICCNlSbk8/Qx+A8OdZqR1It3/qtItmY1K3qBdpIzsR2xSIs2fxidHDKQw2eWvyJ
	ck8/3Kl8JK3olHr8wGESaWmshouuod5G2WZ55bbWx89Msfon0uGck5NQ+vyWtN6Wn3A+AmTvd5w
	KIkaAZ9j9Y/qy+XoYmcr2TTuvgrfEmcVQGSV9FWSseBX3I24F35WPC4YR/S9b76E+NEx9KDwwcW
	6xpjhUPRdD+meN7tqJ6o=
X-Google-Smtp-Source: AGHT+IEY39yKNpHOwhu+b8E85JfZO5GXoHp0A73FES6zZeZtQwPXvLC0BV0HcFzY55ZLXxqy2VO9oA==
X-Received: by 2002:a17:907:9405:b0:b07:c9b2:dbd with SMTP id a640c23a62f3a-b07c9b20f2cmr456963866b.4.1757724328684;
        Fri, 12 Sep 2025 17:45:28 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd5casm460965366b.68.2025.09.12.17.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:45:28 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 05/62] init: remove "ramdisk_start" command line parameter, which controls starting block number of initrd
Date: Sat, 13 Sep 2025 00:37:44 +0000
Message-ID: <20250913003842.41944-6-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is preparation for initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/blockdev/ramdisk.rst  | 3 +--
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 init/do_mounts_rd.c                             | 7 -------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/ramdisk.rst b/Documentation/admin-guide/blockdev/ramdisk.rst
index 9ce6101e8dd9..e57c61108dbc 100644
--- a/Documentation/admin-guide/blockdev/ramdisk.rst
+++ b/Documentation/admin-guide/blockdev/ramdisk.rst
@@ -74,12 +74,11 @@ arch/x86/boot/Makefile.
 
 Some of the kernel command line boot options that may apply here are::
 
-  ramdisk_start=N
   ramdisk_size=M
 
 If you make a boot disk that has LILO, then for the above, you would use::
 
-	append = "ramdisk_start=N ramdisk_size=M"
+	append = "ramdisk_size=M"
 
 4) An Example of Creating a Compressed RAM Disk
 -----------------------------------------------
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f940c1184912..07e8878f1e13 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5285,8 +5285,6 @@
 	ramdisk_size=	[RAM] Sizes of RAM disks in kilobytes
 			See Documentation/admin-guide/blockdev/ramdisk.rst.
 
-	ramdisk_start=	[RAM] RAM disk image start address
-
 	random.trust_cpu=off
 			[KNL,EARLY] Disable trusting the use of the CPU's
 			random number generator (if available) to
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index 8e0a774a9c6f..864fa88d9f89 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -17,13 +17,6 @@
 static struct file *in_file, *out_file;
 static loff_t in_pos, out_pos;
 
-static int __init ramdisk_start_setup(char *str)
-{
-	/* will be removed in next commit */
-	return 1;
-}
-__setup("ramdisk_start=", ramdisk_start_setup);
-
 static int __init crd_load(decompress_fn deco);
 
 /*
-- 
2.47.2


