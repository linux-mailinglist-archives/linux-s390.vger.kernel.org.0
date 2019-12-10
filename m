Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3331B117F25
	for <lists+linux-s390@lfdr.de>; Tue, 10 Dec 2019 05:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfLJErp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 9 Dec 2019 23:47:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35086 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfLJErn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 23:47:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id b19so8409519pfo.2
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2019 20:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EiQDn6/0oRuwTLnfNvzdiHGZKSMrLbDZhPom2rMZn7o=;
        b=WI2BC14zZiQ98S0DzLqneHxoV18dt5gpqrlVywoE5oHdg5Nlck/8qvJGmFxuUzZ160
         kjo1gTrn0FS/5oKF8n1ZyXpA2/u2Ffzxnhl4fBdAsjpQ5rGl9rvtZ7NjL/26AIget8jj
         UTKZNquTzxwyrmTm1IXBllkukRs5NwAkynJ+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EiQDn6/0oRuwTLnfNvzdiHGZKSMrLbDZhPom2rMZn7o=;
        b=ZSi2QOtDzDwxPj1e9FX+3B2lHRZ0/PbIB5SSlS8Blzs+2LvqwbmpdlMtODYxJONdLA
         Vd2A0nTMi65FTTf2Euqxc7TyUK8To+8z64z5KL/0iP75XV/qL3/5REsaf4d8SsrkM/g3
         4yqTxuqFNoL8WMGuO0bA4Q/9Irv6zMe5+4ud80wQ0E7NrF2nvJnZ/g+/NfLO24l5D/cI
         6q8VIdQBDNNN75FINNmW+pDD5hYaiWupFu2YmzDuN6LpMK40qpErzX+gsLAnA/IsVA/1
         IlGrpYeCfxeu5DwhSDOCaSIvIzfYQlCPBYii+tjNmzzqbzGYkpyNttA0HTOuw9Sw6fpZ
         HDRg==
X-Gm-Message-State: APjAAAVi9gswb/s7UFyXbgVkSfmjFeEBGLCpAlfFnPQP/HHXibd08BT2
        8Gw5RYnTmApUKvYpenLoS2HaVA==
X-Google-Smtp-Source: APXvYqwENZz+Juyen/2aq5gIiV77utFbr37CGrm9NGV3YB5/lvZeMjOVCPCut/3HTEKuNdLqG8oHmw==
X-Received: by 2002:a63:5d03:: with SMTP id r3mr22623144pgb.306.1575953263265;
        Mon, 09 Dec 2019 20:47:43 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-e460-0b66-7007-c654.static.ipv6.internode.on.net. [2001:44b8:1113:6700:e460:b66:7007:c654])
        by smtp.gmail.com with ESMTPSA id r6sm1166225pfh.91.2019.12.09.20.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 20:47:42 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 3/4] kasan: Document support on 32-bit powerpc
Date:   Tue, 10 Dec 2019 15:47:13 +1100
Message-Id: <20191210044714.27265-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210044714.27265-1-dja@axtens.net>
References: <20191210044714.27265-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

KASAN is supported on 32-bit powerpc and the docs should reflect this.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 Documentation/dev-tools/kasan.rst |  3 ++-
 Documentation/powerpc/kasan.txt   | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/powerpc/kasan.txt

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index e4d66e7c50de..4af2b5d2c9b4 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -22,7 +22,8 @@ global variables yet.
 Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
 
 Currently generic KASAN is supported for the x86_64, arm64, xtensa and s390
-architectures, and tag-based KASAN is supported only for arm64.
+architectures. It is also supported on 32-bit powerpc kernels. Tag-based KASAN
+is supported only on arm64.
 
 Usage
 -----
diff --git a/Documentation/powerpc/kasan.txt b/Documentation/powerpc/kasan.txt
new file mode 100644
index 000000000000..a85ce2ff8244
--- /dev/null
+++ b/Documentation/powerpc/kasan.txt
@@ -0,0 +1,12 @@
+KASAN is supported on powerpc on 32-bit only.
+
+32 bit support
+==============
+
+KASAN is supported on both hash and nohash MMUs on 32-bit.
+
+The shadow area sits at the top of the kernel virtual memory space above the
+fixmap area and occupies one eighth of the total kernel virtual memory space.
+
+Instrumentation of the vmalloc area is not currently supported, but modules
+are.
-- 
2.20.1

