Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9528A9BC
	for <lists+linux-s390@lfdr.de>; Mon, 12 Aug 2019 23:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfHLVvX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 12 Aug 2019 17:51:23 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35670 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfHLVvX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 12 Aug 2019 17:51:23 -0400
Received: by mail-pl1-f202.google.com with SMTP id s21so61787051plr.2
        for <linux-s390@vger.kernel.org>; Mon, 12 Aug 2019 14:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VzbGHvSiySq50YMMXV5wIRss5YK1rFgm4/UGnmN70Bc=;
        b=fAfaiSlH3IJrNJyZYLgYtoIVY8VZlqGfi5Z1XEd34Hclac8Tlt1XU022vSoo6lpHqW
         WT5ZYdOnF51c3AJ+HgQLgSxq1DFgNbpPZFxvoOpgOi8CLocNEf/zT6VX0F2CI56S+DGU
         emR9pGJLtKNGCGQGSx/vmN9VKkZcYZVXI6eXGk1DQEFDNeHCD/bdYD6Zet1y/2Gzi9uE
         yf/jN+kbTfyFtb4u9PsKcmr7JPvUHlj3Oa0vtajMh2hl9bXBiepZSxxAR7vIHlyXgTiy
         3qSQ1ycRcwY27pQbPVEKnAVbB3qlQm8NnHi8Ju6BN+Yoi5wFlqrTPtF5AwdB6r/eozZn
         AJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VzbGHvSiySq50YMMXV5wIRss5YK1rFgm4/UGnmN70Bc=;
        b=Dp1imcqDLNrapEcrpTnq+f2oD0p6NjiPAkA4OFP+NF8cW92rk9V9sMxauYEfX43Qbc
         aAkqQf7qGIuwuB2S8u8yhRdWaUYv+Psu68iu4oPyCUhhYLFju4Kf1aW7vCOq+4MO5HBL
         DUHkMddD/tfxoh14SyPdH5/raex0Spc1rW4K20X6hjO6WCdOPSIHQ3TiPJ/GVfeECd8n
         QF51egg1/F17JZUKrd0IvMy4l0E2Uarrt+r6vx5GzrA548O2CXC1LIu7czotTdFCuXKC
         4wAFx/+yV9AEONiHQz+VIj7e0nSSulWjbOXH97L2i1QTk/4X7XpkKE3eP65CcRPoiDw5
         1Wyw==
X-Gm-Message-State: APjAAAUtvtpcuK3zggWNv0mwnrCDotB5xg3ZBfULxUqLXIdi5fNTzVPU
        XqlzN1wK2B+jIV9ToUJaV/3wzXSOtmXjWw5dMRg=
X-Google-Smtp-Source: APXvYqxzQCyThBwBKrfD6856yni3bdzA7zdg2TImP8qBYmAZ8RHmc6ZzA/B5OR4SphKOBUyy2O28WZ+h0SMYwe93/kc=
X-Received: by 2002:a63:2685:: with SMTP id m127mr31628780pgm.6.1565646682512;
 Mon, 12 Aug 2019 14:51:22 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:50:34 -0700
Message-Id: <20190812215052.71840-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 01/16] s390/boot: fix section name escaping
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     sedat.dilek@gmail.com, jpoimboe@redhat.com, yhs@fb.com,
        miguel.ojeda.sandonis@gmail.com,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/s390/boot/startup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 7b0d05414618..26493c4ff04b 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -46,7 +46,7 @@ struct diag_ops __bootdata_preserved(diag_dma_ops) = {
 	.diag0c = _diag0c_dma,
 	.diag308_reset = _diag308_reset_dma
 };
-static struct diag210 _diag210_tmp_dma __section(".dma.data");
+static struct diag210 _diag210_tmp_dma __section(.dma.data);
 struct diag210 *__bootdata_preserved(__diag210_tmp_dma) = &_diag210_tmp_dma;
 void _swsusp_reset_dma(void);
 unsigned long __bootdata_preserved(__swsusp_reset_dma) = __pa(_swsusp_reset_dma);
-- 
2.23.0.rc1.153.gdeed80330f-goog

