Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C30851A6D3
	for <lists+linux-s390@lfdr.de>; Wed,  4 May 2022 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354592AbiEDRAu (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 4 May 2022 13:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355790AbiEDRAZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 May 2022 13:00:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ECD4C414;
        Wed,  4 May 2022 09:52:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A3EFB827A1;
        Wed,  4 May 2022 16:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03F2C385A4;
        Wed,  4 May 2022 16:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651683123;
        bh=lxOCNLhoXuv1p/yYbOt/qn66HbF114gIdpkYgvRyQOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ByThSz51YQJeoKp3V3/apWHP8kEXspZgbCXW/bb5roYfo64bzWtNg3wXuBfEfnb81
         4DBpa4uBnd51gRLBRBtq9vEIdm4lnyGZ+F4q+8APh1hKNKOaHCcdehORKIdNaDHJxA
         V/WSEgevkZFoBtwI8lX7dJaUQRfO95bU1OWBGokI=
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
Subject: [PATCH 5.10 114/129] perf symbol: Update symbols__fixup_end()
Date:   Wed,  4 May 2022 18:45:06 +0200
Message-Id: <20220504153030.353188622@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504153021.299025455@linuxfoundation.org>
References: <20220504153021.299025455@linuxfoundation.org>
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

commit 8799ebce84d672aae1dc3170510f6a3e66f96b11 upstream.

Now arch-specific functions all do the same thing.  When it fixes the
symbol address it needs to check the boundary between the kernel image
and modules.  For the last symbol in the previous region, it cannot
know the exact size as it's discarded already.  Thus it just uses a
small page size (4096) and rounds it up like the last symbol.

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
Link: https://lore.kernel.org/r/20220416004048.1514900-3-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/symbol.c |   29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -217,8 +217,8 @@ again:
 	}
 }
 
-void symbols__fixup_end(struct rb_root_cached *symbols,
-			bool is_kallsyms __maybe_unused)
+/* Update zero-sized symbols using the address of the next symbol */
+void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
 {
 	struct rb_node *nd, *prevnd = rb_first_cached(symbols);
 	struct symbol *curr, *prev;
@@ -232,8 +232,29 @@ void symbols__fixup_end(struct rb_root_c
 		prev = curr;
 		curr = rb_entry(nd, struct symbol, rb_node);
 
-		if (prev->end == prev->start || prev->end != curr->start)
-			arch__symbols__fixup_end(prev, curr);
+		/*
+		 * On some architecture kernel text segment start is located at
+		 * some low memory address, while modules are located at high
+		 * memory addresses (or vice versa).  The gap between end of
+		 * kernel text segment and beginning of first module's text
+		 * segment is very big.  Therefore do not fill this gap and do
+		 * not assign it to the kernel dso map (kallsyms).
+		 *
+		 * In kallsyms, it determines module symbols using '[' character
+		 * like in:
+		 *   ffffffffc1937000 T hdmi_driver_init  [snd_hda_codec_hdmi]
+		 */
+		if (prev->end == prev->start) {
+			/* Last kernel/module symbol mapped to end of page */
+			if (is_kallsyms && (!strchr(prev->name, '[') !=
+					    !strchr(curr->name, '[')))
+				prev->end = roundup(prev->end + 4096, 4096);
+			else
+				prev->end = curr->start;
+
+			pr_debug4("%s sym:%s end:%#" PRIx64 "\n",
+				  __func__, prev->name, prev->end);
+		}
 	}
 
 	/* Last entry */


