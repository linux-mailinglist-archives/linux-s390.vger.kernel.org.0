Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EF251B920
	for <lists+linux-s390@lfdr.de>; Thu,  5 May 2022 09:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbiEEHfZ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 5 May 2022 03:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345015AbiEEHfY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 May 2022 03:35:24 -0400
Received: from condef-07.nifty.com (condef-07.nifty.com [202.248.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3B84833E
        for <linux-s390@vger.kernel.org>; Thu,  5 May 2022 00:31:45 -0700 (PDT)
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-07.nifty.com with ESMTP id 2457QWdO007690
        for <linux-s390@vger.kernel.org>; Thu, 5 May 2022 16:26:32 +0900
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2457Neno019426;
        Thu, 5 May 2022 16:23:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2457Neno019426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651735428;
        bh=jiny9e/0ekLHfzDMPj/sTAYkp3K4e6Ir8SZeJf0qunI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8CzChdZOXXECM2SJqlUNY/RhAyMMyUj53jsSphu1U+2MxbScJI/0J74sbJu8dUVP
         FvXOIHejc8zclit4u9J9UEq+wuFT42/BAOI+9YhBebmsgWrNKPRJCOpl66DmR5cNXU
         AAH4LfUbUt2jr9/+WwldUA50jaKLwfgV0Vt6Mbglmro41BirayumolaEHice+urhim
         YzIGOo5QiBzUFigZRKwD/Preqo125kSiD66lcLlMhrgPG6RwtPJnldGl+gdQq18juZ
         bwQo7ErSMekWvQHB8+6TXyXu2TCug/4pBJ48orLidkmwiG2uk+hE57AmtmKzRpxIYW
         UldyhAx1qO4aA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nicolas Schier a <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 06/15] kbuild: record symbol versions in *.cmd files
Date:   Thu,  5 May 2022 16:22:35 +0900
Message-Id: <20220505072244.1155033-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

When CONFIG_MODVERSIONS=y, the output from genksyms is saved in
separate *.symversions files, and will be used much later when
CONFIG_LTO_CLANG=y because it is impossible to update LLVM bit code
here.

This approach is not robust because:

 - *.symversions may or may not exist. If *.symversions does not
   exist, we never know if it is missing for legitimate reason
   (i.e. no EXPORT_SYMBOL) or something bad has happened (for
   example, the user accidentally deleted it). Once it occurs,
   it is not self-healing because *.symversions is generated
   as a side effect.

 - stale (i.e. invalid) *.symversions might be picked up if an
   object is generated in a non-ordinary way, and corresponding
   *.symversions (, which was generated by old builds) just happen
   to exist.

A more robust approach is to save symbol versions in *.cmd files
because:

 - *.cmd always exists (if the object is generated by if_changed
   rule or friends). Even if the user accidentally deletes it,
   it will be regenerated in the next build.

 - *.cmd is always re-generated when the object is updated. This
   avoid stale version information being picked up.

I will remove *.symversions later.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Tested-by: Nicolas Schier <nicolas@fjasle.eu>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

(no changes since v2)

Changes in v2:
  - Fix CONFIG_MODULE_REL_CRCS=y case

 scripts/Makefile.build | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f6a506318795..a1023868775f 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -171,10 +171,17 @@ ifdef CONFIG_MODVERSIONS
 
 # Generate .o.symversions files for each .o with exported symbols, and link these
 # to the kernel and/or modules at the end.
+
+genksyms_format_rel_crc := [^_]*__crc_\([^ ]*\) = \.; LONG(\([^)]*\)).*
+genksyms_format_normal := __crc_\(.*\) = \(.*\);
+genksyms_format := $(if $(CONFIG_MODULE_REL_CRCS),$(genksyms_format_rel_crc),$(genksyms_format_normal))
+
 gen_symversions =								\
 	if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then			\
 		$(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
 		    > $@.symversions;						\
+		sed -n 's/$(genksyms_format)/$(pound)SYMVER \1 \2/p' $@.symversions \
+			>> $(dot-target).cmd;					\
 	else									\
 		rm -f $@.symversions;						\
 	fi
-- 
2.32.0

