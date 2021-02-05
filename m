Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186E03119E4
	for <lists+linux-s390@lfdr.de>; Sat,  6 Feb 2021 04:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhBFDWm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 5 Feb 2021 22:22:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50915 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhBFDP5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Feb 2021 22:15:57 -0500
Received: from mail-ot1-f70.google.com ([209.85.210.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1l8ABD-00085F-5u
        for linux-s390@vger.kernel.org; Fri, 05 Feb 2021 23:06:23 +0000
Received: by mail-ot1-f70.google.com with SMTP id f15so4343994oto.9
        for <linux-s390@vger.kernel.org>; Fri, 05 Feb 2021 15:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jL+PN/3Ia+pzgjJLL+mRMyGT9OjrJOTglHNfm1iXNKw=;
        b=g768vp/2cUpnqUUba9k/bD6SvZ7OWGbZrsTDrBU4CS3Uw+U5++JPup4zgHf2sG17js
         znlH4D4eSCtkFk1zBKTKe/Tz4vWZkmxS0CFv0qMZyJHCYZRMnQZtisS4YHb84/CeCDBw
         h6PuXauk/cTNdehOZepR7dnEZ6WMM88ENlKJua392pY9wKeqRRAokaBNUfiMksSh4THB
         GeK8sh56zkFObetfCORo7sdFRZx3uVOhZaytdPRmHvsll45wo1lWVYRCM/UBJgJdULyt
         L/U6ChDdmcMPjHZd99o6l55o/tEfrvvQt8j/JcV0ryH+QJK58YEt1O3C0YcShvd8XN8a
         JteA==
X-Gm-Message-State: AOAM533FMZetW0e9+xQ9VvHVX2xGCCD2aqgkXORlNbX3rMtgrGPk5agj
        I8oQ5D+hjPvGTfwxXH+wGLkS819tWln/JlQ7PzTCXzWtQd6+3vj44eih2dcCXVnYUp6s2sdupPY
        29zdffQCuOipG5jQTrSNXc9GsrgOpkjarGxULxcc=
X-Received: by 2002:a9d:4e81:: with SMTP id v1mr4028716otk.18.1612566382223;
        Fri, 05 Feb 2021 15:06:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvs9TQA5TKt+CAisx2zwMD4RJd1+tEjp6Ia1b1F+JZJ5RCBrJ1ib/XXQFu7GcbeKbNLoXSdA==
X-Received: by 2002:a9d:4e81:: with SMTP id v1mr4028705otk.18.1612566381984;
        Fri, 05 Feb 2021 15:06:21 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:2b7:eb67:ff8d:8b15])
        by smtp.gmail.com with ESMTPSA id m10sm2087472otp.19.2021.02.05.15.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 15:06:21 -0800 (PST)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Chris Down <chris@chrisdown.name>,
        Amir Goldstein <amir73il@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs: Disallow CONFIG_TMPFS_INODE64 on s390
Date:   Fri,  5 Feb 2021 17:06:20 -0600
Message-Id: <20210205230620.518245-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This feature requires ino_t be 64-bits, which is true for every
64-bit architecture but s390, so prevent this option from being
selected there.

Fixes: ea3271f7196c ("tmpfs: support 64-bit inums per-sb")
Cc: <stable@vger.kernel.org> # v5.9+
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 fs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index aa4c12282301..3347ec7bd837 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -203,7 +203,7 @@ config TMPFS_XATTR
 
 config TMPFS_INODE64
 	bool "Use 64-bit ino_t by default in tmpfs"
-	depends on TMPFS && 64BIT
+	depends on TMPFS && 64BIT && !S390
 	default n
 	help
 	  tmpfs has historically used only inode numbers as wide as an unsigned
-- 
2.29.2

