Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7731B415257
	for <lists+linux-s390@lfdr.de>; Wed, 22 Sep 2021 23:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbhIVVHa (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 22 Sep 2021 17:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbhIVVH3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 22 Sep 2021 17:07:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFFCC06175F
        for <linux-s390@vger.kernel.org>; Wed, 22 Sep 2021 14:05:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u8so16756312lff.9
        for <linux-s390@vger.kernel.org>; Wed, 22 Sep 2021 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/PcqjgcRCkyIpO5H00bhPWTTbPCMNXWR4nKgirdi3Io=;
        b=xEkq7SUZRewChVZqWhm4cS96l8pPzSSEz+ScgQL56dgjn10FcSw+jLPv0OY9bYezIP
         CYphaUGJXn/snvtDU3KSfg579Nb5Qlk3NtUo6CuASAlclCh3ui7cA33wRO6foyyQk9sK
         Mw3x0Ft59CKVBwMroO3W4lugA/tv5mEWbElbrHB+wIwMc5ZNjOZSS8KT6h+Zon+cf4qv
         JmEltnmffmbEBqUsebTV11v0B5U1mVwBUj3sW1gLZspQ54hm7TrP9j1QPJEblcLAhwI2
         nEggNK9m8gYxewjcBCYSYCHLIhl9iSTZmO6vl1lqR1Tl54TSO4jEGxDT96zBALyLtnLS
         Hi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/PcqjgcRCkyIpO5H00bhPWTTbPCMNXWR4nKgirdi3Io=;
        b=Tg1vc+qoajm1C1o6XwK2D+ZNL1xpPoO/Qyp7VYotpID7X/LeGTKvLtmcZu3Cu8fEQN
         VkaE4M6MEsC7nrH4oSkNF3eaK7ogOhRt2kJRNS1VmLVnBGu99GBg/UQSThkhiabyLPL6
         J+TiirueU/H82SF3XsTmEQ4ZdQYJ02pcFS9uG9PwvBQMduaRwWApcwGnUAQ7W8awnNgL
         2+GIIHftnY101qEif4K23nnQqYL2njhApNn0boNTfwvF4ehWuBK2KiN7e/DXYoCtEWtn
         MFNsNEpD4686gVQGTOADLAeordkLYWvZ0WJ4v1XYOiWQ8+1tQZH2OjCHQqlgVVoVoGfZ
         oi2w==
X-Gm-Message-State: AOAM532uiTUjIxztdTzOkUtO8h6NTxkG2E17ayOc5PlNICJnW1N3B/2h
        LpAPtmw+XGp1LOHHm4kqjAGlOw==
X-Google-Smtp-Source: ABdhPJxFaBhI/uy8npc3Dtax2q52q/CAXrrCmDjvazERLjrealUJSj+rQLNB+0RcTEMnHlaiKFjmmA==
X-Received: by 2002:a05:6512:5c2:: with SMTP id o2mr917110lfo.207.1632344757440;
        Wed, 22 Sep 2021 14:05:57 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id bi33sm370467ljb.89.2021.09.22.14.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:05:56 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 60F2A10304D; Thu, 23 Sep 2021 00:05:58 +0300 (+03)
Date:   Thu, 23 Sep 2021 00:05:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
Message-ID: <20210922210558.itofvu3725dap5xx@box.shutemov.name>
References: <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com>
 <YUoao0LlqQ6+uBrq@zn.tnic>
 <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
 <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
 <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
 <01891f59-7ec3-cf62-a8fc-79f79ca76587@amd.com>
 <20210922143015.vvxvh6ec73lffvkf@box.shutemov.name>
 <YUuJZ2qOgbdpfk6N@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUuJZ2qOgbdpfk6N@zn.tnic>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Sep 22, 2021 at 09:52:07PM +0200, Borislav Petkov wrote:
> On Wed, Sep 22, 2021 at 05:30:15PM +0300, Kirill A. Shutemov wrote:
> > Not fine, but waiting to blowup with random build environment change.
> 
> Why is it not fine?
> 
> Are you suspecting that the compiler might generate something else and
> not a rip-relative access?

Yes. We had it before for __supported_pte_mask and other users of
fixup_pointer().

See for instance 4a09f0210c8b ("x86/boot/64/clang: Use fixup_pointer() to
access '__supported_pte_mask'")

Unless we find other way to guarantee RIP-relative access, we must use
fixup_pointer() to access any global variables.

-- 
 Kirill A. Shutemov
