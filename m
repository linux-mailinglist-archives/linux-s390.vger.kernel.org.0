Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71C7A13D44D
	for <lists+linux-s390@lfdr.de>; Thu, 16 Jan 2020 07:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgAPG0o (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 16 Jan 2020 01:26:44 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35691 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbgAPG0o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Jan 2020 01:26:44 -0500
Received: by mail-pj1-f65.google.com with SMTP id s7so1088365pjc.0
        for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2020 22:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SI5glm9tTBFJlI56hJYs/doyA7zUbu5YUKwxBp+hpYY=;
        b=GfTRpKom0tPQq8D4aXQyI2foQczp9UuJXSAyw66CT6hkWQrJmpym0PT6cvNRyGY8Uk
         0VvHyXu1/QQxb3+Jjk5FQ//6OW1fSF4+GEXglW8TGLZKjd4szY+kf1EU0mFv2H1ywD7M
         VbwSiZQaQuyCsyymCLbnA4sRvShcMEGUaENZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SI5glm9tTBFJlI56hJYs/doyA7zUbu5YUKwxBp+hpYY=;
        b=sS7XnJU4Co49henBQQnE6GH3FjosQ0jdTR7IwXwBZX2jE59tGvuCWHfrnvBZSc6KAq
         BKYro0yTF+5iB1iaO5Q8nWn0vg6K6LQuuyvI3DgGhfh3M/p0kK8CUbkwWJCFzengupxn
         Q7LSRMQUPebAiM5ojOsBvefXrESbNZA5exiKY+hLGs18R9vp9ITuOTz7ajX1GujIoIMu
         HHEJCGsp5pB9mkZGVl3YRKOp3Wi6q7BsYVpbVfj+rom7Y/e76v6HFmNTG/d7t5gfThKd
         OLagsAjnqS6UWyAbVgRlXSO3zdn9jbEgIhmOU9EUPesW3D97qOoLxJZ+S515xUKrSdu8
         FI/A==
X-Gm-Message-State: APjAAAURgiYf5nH3JZh8jcX5KXxw9mjrOnhViq1a9PoCnXX7OPdi9tY/
        3jAOZMDR+kPuQ2lUsm6BJKpfPA==
X-Google-Smtp-Source: APXvYqyt2Oz5lp6I4QYJC6msD4qYWnWAGuSCIA+DMfGiAHr8tDPwjSQJBDVs1A0BbM5XvepejAB4uQ==
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr29998912plk.290.1579156003508;
        Wed, 15 Jan 2020 22:26:43 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-097c-7eed-afd4-cd15.static.ipv6.internode.on.net. [2001:44b8:1113:6700:97c:7eed:afd4:cd15])
        by smtp.gmail.com with ESMTPSA id r3sm24681158pfg.145.2020.01.15.22.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:26:42 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org, dvyukov@google.com,
        christophe.leroy@c-s.fr, Daniel Axtens <dja@axtens.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>
Subject: [PATCH v2 3/3] kasan: initialise array in kasan_memcmp test
Date:   Thu, 16 Jan 2020 17:26:25 +1100
Message-Id: <20200116062625.32692-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116062625.32692-1-dja@axtens.net>
References: <20200116062625.32692-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

memcmp may bail out before accessing all the memory if the buffers
contain differing bytes. kasan_memcmp calls memcmp with a stack array.
Stack variables are not necessarily initialised (in the absence of a
compiler plugin, at least). Sometimes this causes the memcpy to bail
early thus fail to trigger kasan.

Make sure the array initialised to zero in the code.

No other test is dependent on the contents of an array on the stack.

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 lib/test_kasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index a130d75b9385..519b0f259e97 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -619,7 +619,7 @@ static noinline void __init kasan_memcmp(void)
 {
 	char *ptr;
 	size_t size = 24;
-	int arr[9];
+	int arr[9] = {};
 
 	pr_info("out-of-bounds in memcmp\n");
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
-- 
2.20.1

