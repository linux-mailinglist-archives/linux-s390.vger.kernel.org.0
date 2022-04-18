Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383A0505F8E
	for <lists+linux-s390@lfdr.de>; Tue, 19 Apr 2022 00:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiDRWCo (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 18 Apr 2022 18:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiDRWCb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Apr 2022 18:02:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60DE6589
        for <linux-s390@vger.kernel.org>; Mon, 18 Apr 2022 14:59:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso502166pjj.2
        for <linux-s390@vger.kernel.org>; Mon, 18 Apr 2022 14:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cLLWAAHArn9WgPwOUwNflPPJDgjsRY1O3bHGAhIDsQw=;
        b=LTURonE53ti9q/GT1aK7iRoPMpGAeCy1e4EeYMoQ5ND31pPzYRrBIuxOtS32aAiFM+
         1XHlY0ymuxtf7KP5zzxh8j9ip4/ZkYqKkInt8TY5JnA0taa6ag1p6HhrtkPYOmL/X1BS
         68H/ZEsyd88OXRqhJx4ed+KaxwMRzhvwF+Q30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cLLWAAHArn9WgPwOUwNflPPJDgjsRY1O3bHGAhIDsQw=;
        b=ldWyKmY4FZZfHJrw7N6YxZlUdMo5xfOEW/flFbnXkNWpk7qM7kT96MXDTDPov5DqtE
         zK1D2zasXTfMe3z7O8Z0xKzVl+YFgh9PFGxamop3OYsayueUbXT0iGL2nX5LPk4/01RA
         oyRLG4Fl8s8BrUGcLeqQYwXo7Lb48CBEf3z+dQBqJWjlzHRlUQ3vW0kyFym5Va/hyku3
         bxXkXPYVTAsRMY/ZRfFYKuWORPIq+AgyRWKKr4KBcrePGzZGiLSZzreLVIMxsBZvmb5t
         mUIgGIFvYTV92WBz4uAX4vupYWVRypexF0yqtZJS7NjxTW++qlTy6S8SzQsMmeiwufjZ
         8fNw==
X-Gm-Message-State: AOAM531yAeTQPGFCj7BxZEXA233LZhJLtiEgmMZHqRwFA/bOdJjHkfrJ
        7Aekr9qmQMO4Zs47djTLaAhb4w==
X-Google-Smtp-Source: ABdhPJysM2kkydsu6S512r9sNHn81bBvZQZwemOKp8WmD7sADc0kfHvR6/TUHLqhcn1MQ99fL/O1Og==
X-Received: by 2002:a17:902:6bc2:b0:158:a26b:5884 with SMTP id m2-20020a1709026bc200b00158a26b5884mr12917161plt.38.1650319190427;
        Mon, 18 Apr 2022 14:59:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z15-20020a056a001d8f00b004fda37855ddsm12953099pfw.168.2022.04.18.14.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 14:59:50 -0700 (PDT)
Date:   Mon, 18 Apr 2022 14:59:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     He Zhe <zhe.he@windriver.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, hpa@zytor.com,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/8] arm64: stacktrace: Add arch_within_stack_frames
Message-ID: <202204181457.9DE190CE@keescook>
References: <20220418132217.1573072-1-zhe.he@windriver.com>
 <20220418132217.1573072-3-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418132217.1573072-3-zhe.he@windriver.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Apr 18, 2022 at 09:22:11PM +0800, He Zhe wrote:
> This function checks if the given address range crosses frame boundary.
> It is based on the existing x86 algorithm, but implemented via stacktrace.
> This can be tested by USERCOPY_STACK_FRAME_FROM and
> USERCOPY_STACK_FRAME_TO in lkdtm.

Hi,

Thanks for doing this implementation! One reason usercopy hardening
didn't persue doing a "full" stacktrace was because it seemed relatively
expensive. Did you do any usercopy-heavily workload testing to see if
there was a noticeable performance impact?

It would be nice to block the exposure of canaries and PAC bits, though,
so I'm not opposed, but I'd like to get a better sense of how "heavy"
this might be.

Thanks!

-Kees

-- 
Kees Cook
