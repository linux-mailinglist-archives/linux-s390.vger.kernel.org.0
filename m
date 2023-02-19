Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9B069C256
	for <lists+linux-s390@lfdr.de>; Sun, 19 Feb 2023 21:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjBSUij (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 19 Feb 2023 15:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjBSUii (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 19 Feb 2023 15:38:38 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69906CC30
        for <linux-s390@vger.kernel.org>; Sun, 19 Feb 2023 12:38:37 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id d137so499423pga.2
        for <linux-s390@vger.kernel.org>; Sun, 19 Feb 2023 12:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cNhE2FASeH5o8yi0ZLyiaK0kUF7pA0USqp0ltHH/0Fo=;
        b=TJUJ1J2ArJiZ+C52sbA4rJUl5jkwfEU0A4lmboDWRNDWEfBXuFPkUHzTEyJZAm+S4p
         Wge2lQiBs7TGtXwWkE0b1xhZw6outUBXabRYNKQBImrjMsw8dd8fr8oWOeq3BFAQBjtb
         8uo983lQimMC+dk9fekE1rNd+VY9r+8q/tjI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNhE2FASeH5o8yi0ZLyiaK0kUF7pA0USqp0ltHH/0Fo=;
        b=j8X+teUKhifjyRroQ8RLTPoKCWr68FYoQusUHslZNy4FaB+4pbBGn316/Jkias8BCJ
         OQWdMslLFOYAGxmf4GyBqhJe6EKaRZ+qCTRliqplLdUnuHyKbpWgv3OK7yKvDPaMIU6D
         i3coQHMNQioCmNVJdz150FWkGSD/bctkiiuz+MFvxdsdOp2cZXSO9vUdD/ssFxLRNLgZ
         DBypQNHcHVDHPl8NZJVTCwopgxJ1qNjQygFo+5S/dfqEtJcqdvmgdVESSjgpaQ6Bp2Y9
         vA0H6ApLyJcTeVOs/TGhFch96i9TctS/WkdrEeB9k32qhMA1WobMaWKCew2fyEZmekWV
         JChQ==
X-Gm-Message-State: AO0yUKU4Qa0QgQ6IAMRQ4NFtEPbYRzeUCnOoJ7a7HNvDhK0429JC3Yk+
        XtiCJfuV1N+p+xbhE9rGye7t1Q==
X-Google-Smtp-Source: AK7set/XVAl5klPqjExLu4JTPo0Bl98f24f9lS+8n7DA1eEGRV2Dh4JhkKn00B8IKrJYG+VivvI0vw==
X-Received: by 2002:a62:1a57:0:b0:58d:d546:8012 with SMTP id a84-20020a621a57000000b0058dd5468012mr769767pfa.0.1676839116854;
        Sun, 19 Feb 2023 12:38:36 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p21-20020aa78615000000b005afda1496c6sm2648912pfn.31.2023.02.19.12.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 12:38:36 -0800 (PST)
Message-ID: <63f288cc.a70a0220.5558c.3c92@mx.google.com>
X-Google-Original-Message-ID: <202302191237.@keescook>
Date:   Sun, 19 Feb 2023 12:38:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v6 11/41] mm: Introduce pte_mkwrite_kernel()
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-12-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-12-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Feb 18, 2023 at 01:14:03PM -0800, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> One of these changes is to allow for pte_mkwrite() to create different
> types of writable memory (the existing conventionally writable type and
> also the new shadow stack type). Future patches will convert pte_mkwrite()
> to take a VMA in order to facilitate this, however there are places in the
> kernel where pte_mkwrite() is called outside of the context of a VMA.
> These are for kernel memory. So create a new variant called
> pte_mkwrite_kernel() and switch the kernel users over to it. Have
> pte_mkwrite() and pte_mkwrite_kernel() be the same for now. Future patches
> will introduce changes to make pte_mkwrite() take a VMA.
> 
> Only do this for architectures that need it because they call pte_mkwrite()
> in arch code without an associated VMA. Since it will only currently be
> used in arch code, so do not include it in arch_pgtable_helpers.rst.
> 
> Cc: linux-doc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: xen-devel@lists.xenproject.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

I think it's a little weird that it's the only PTE helper taking a vma,
but it does seem like the right approach.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
