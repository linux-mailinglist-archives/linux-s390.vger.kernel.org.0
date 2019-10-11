Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03E14D4519
	for <lists+linux-s390@lfdr.de>; Fri, 11 Oct 2019 18:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfJKQLq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 11 Oct 2019 12:11:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43963 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfJKQLq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 11 Oct 2019 12:11:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id f21so4668514plj.10
        for <linux-s390@vger.kernel.org>; Fri, 11 Oct 2019 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G6L52gHbcOVXjcPSYcPZfDCdfNGSvtith//1lglITt4=;
        b=U5/N6JMiUj9QDTd24aIgmkS/ZCmGBjpKwM7U8CzxrzMf1lqZSNfbZ7O4pwV0bhEzEg
         wudUUYrZzrgNiboJm0ChoceZ3O1LmYFYV3Bvx9uhV6vTeclkuNrnADNJMjD6VX65LBtL
         he7FMaEjTbOKTJQ5f79wUMqxbvVvSYa6+a7mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G6L52gHbcOVXjcPSYcPZfDCdfNGSvtith//1lglITt4=;
        b=VY9ULel3g5Bpem2YbMP9XeFwewmuAch0Mx3f5pfk0FyKS8hVbk2aZ2HMJdD0Vj9bzx
         leckXjl2umQOEWsFi3O7NNlrhm+/tqSdiCYhWqYQPrNhbd5dMCjCts/nSxMjdjaEtbAX
         5mUk72p3OpSsfqUBHTKhdpPwywl42ZCNpEFOzXxKnNI2xua9PbYRZrxu2ziuNNYRkoCJ
         Et4lXwvyRR00uosKLToHrVd/w62d+iOssV0dVTthU+9qNOzqIbV36xEmmiACv5ORzH/t
         YOmJ5PwROF8HDy3EaLf8OWC5wBAKnLn70ESIkvrEI9B82UcCOQynwMSceCWhgk2LR4yL
         l62Q==
X-Gm-Message-State: APjAAAXZJ9UupkgmE2Z9q8Ij6vCz6EmA41E3/7ZTA2gp0HtpkrxIypFJ
        xSojeNDp6UF5ObeTzqmMRnrheg==
X-Google-Smtp-Source: APXvYqybFKi8DEP43HWkgZPyfZo8SqqFMMtnLHZ2tVbdiQx6dZitTSLWHEWMqDIFXmSN2gN3R3/hRg==
X-Received: by 2002:a17:902:bf45:: with SMTP id u5mr15982728pls.62.1570810305781;
        Fri, 11 Oct 2019 09:11:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6sm9294369pfq.169.2019.10.11.09.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 09:11:44 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:11:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        x86@kernel.org, linux-ia64@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-xtensa@linux-xtensa.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-parisc@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org
Subject: Re: [PATCH v2 01/29] powerpc: Rename "notes" PT_NOTE to "note"
Message-ID: <201910110910.48270FC97@keescook>
References: <20191011000609.29728-1-keescook@chromium.org>
 <20191011000609.29728-2-keescook@chromium.org>
 <20191011082519.GI9749@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011082519.GI9749@gate.crashing.org>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Oct 11, 2019 at 03:25:19AM -0500, Segher Boessenkool wrote:
> On Thu, Oct 10, 2019 at 05:05:41PM -0700, Kees Cook wrote:
> > The Program Header identifiers are internal to the linker scripts. In
> > preparation for moving the NOTES segment declaration into RO_DATA,
> > standardize the identifier for the PT_NOTE entry to "note" as used by
> > all other architectures that emit PT_NOTE.
> 
> All other archs are wrong, and "notes" is a much better name.  This
> segment does not contain a single "note", but multiple "notes".

True, but the naming appears to be based off the Program Header name of
"PT_NOTE". Regardless, it is an entirely internal-to-the-linker-script
identifier, so I am just consolidating on a common name with the least
number of collateral changes.

-- 
Kees Cook
