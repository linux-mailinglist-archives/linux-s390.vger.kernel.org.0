Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8988451A848
	for <lists+linux-s390@lfdr.de>; Wed,  4 May 2022 19:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355297AbiEDRKU (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 4 May 2022 13:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356091AbiEDRJB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 May 2022 13:09:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC40B52B02;
        Wed,  4 May 2022 09:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF20DB827A9;
        Wed,  4 May 2022 16:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A9AC385A5;
        Wed,  4 May 2022 16:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651683289;
        bh=tdbDFul+h7mHIZGjR6d9RK6uqNXvSudKR0hDLEN0/i8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1F3vRRt/wFf8oBlygRyovfa5X5Xpl1UNnLr6zPSQdvbn2ccCTudssr6su7YrUjxw
         FPY3IIbwHIUzJyFeNoxf/DoZjne0eAqrCj6iA4EOHLFxLogQqQh8+PnnlD64WIQi0P
         YRXFMOdGmaXzjRfzGV64HEMZjLjD/twHgmnfJPyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Will Deacon <will@kernel.org>, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.15 155/177] perf symbol: Pass is_kallsyms to symbols__fixup_end()
Date:   Wed,  4 May 2022 18:45:48 +0200
Message-Id: <20220504153107.284095273@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504153053.873100034@linuxfoundation.org>
References: <20220504153053.873100034@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

commit 838425f2defe5262906b698752d28fd2fca1aac2 upstream.

The symbol fixup is necessary for symbols in kallsyms since they don't
have size info.  So we use the next symbol's address to calculate the
size.  Now it's also used for user binaries because sometimes they miss
size for hand-written asm functions.

There's a arch-specific function to handle kallsyms differently but
currently it cannot distinguish kallsyms from others.  Pass this
information explicitly to handle it properly.  Note that those arch
functions will be moved to the generic function so I didn't added it to
the arch-functions.

Fixes: 3cf6a32f3f2a4594 ("perf symbols: Fix symbol size calculation condition")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-s390@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://lore.kernel.org/r/20220416004048.1514900-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/symbol-elf.c |    2 +-
 tools/perf/util/symbol.c     |    7 ++++---
 tools/perf/util/symbol.h     |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1290,7 +1290,7 @@ dso__load_sym_internal(struct dso *dso,
 	 * For misannotated, zeroed, ASM function sizes.
 	 */
 	if (nr > 0) {
-		symbols__fixup_end(&dso->symbols);
+		symbols__fixup_end(&dso->symbols, false);
 		symbols__fixup_duplicate(&dso->symbols);
 		if (kmap) {
 			/*
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -217,7 +217,8 @@ again:
 	}
 }
 
-void symbols__fixup_end(struct rb_root_cached *symbols)
+void symbols__fixup_end(struct rb_root_cached *symbols,
+			bool is_kallsyms __maybe_unused)
 {
 	struct rb_node *nd, *prevnd = rb_first_cached(symbols);
 	struct symbol *curr, *prev;
@@ -1456,7 +1457,7 @@ int __dso__load_kallsyms(struct dso *dso
 	if (kallsyms__delta(kmap, filename, &delta))
 		return -1;
 
-	symbols__fixup_end(&dso->symbols);
+	symbols__fixup_end(&dso->symbols, true);
 	symbols__fixup_duplicate(&dso->symbols);
 
 	if (dso->kernel == DSO_SPACE__KERNEL_GUEST)
@@ -1648,7 +1649,7 @@ int dso__load_bfd_symbols(struct dso *ds
 #undef bfd_asymbol_section
 #endif
 
-	symbols__fixup_end(&dso->symbols);
+	symbols__fixup_end(&dso->symbols, false);
 	symbols__fixup_duplicate(&dso->symbols);
 	dso->adjust_symbols = 1;
 
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -192,7 +192,7 @@ void __symbols__insert(struct rb_root_ca
 		       bool kernel);
 void symbols__insert(struct rb_root_cached *symbols, struct symbol *sym);
 void symbols__fixup_duplicate(struct rb_root_cached *symbols);
-void symbols__fixup_end(struct rb_root_cached *symbols);
+void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms);
 void maps__fixup_end(struct maps *maps);
 
 typedef int (*mapfn_t)(u64 start, u64 len, u64 pgoff, void *data);


