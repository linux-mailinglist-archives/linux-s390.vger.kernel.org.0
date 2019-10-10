Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93F4D2ED0
	for <lists+linux-s390@lfdr.de>; Thu, 10 Oct 2019 18:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfJJQr3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 10 Oct 2019 12:47:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43077 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfJJQr3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Oct 2019 12:47:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id f21so3054800plj.10
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e1YZSnr+tf37urRS0Z3ujXsrRMc5cw+9H7NAi1i2jVA=;
        b=izpAwLJ1ZfINeJ1IGvzXfqW7v0EVcZgsTyN1EOshDrEdBCIUSqkIleCU5BZWm63bPM
         eZKMQCfAts2ypPUa2YAeUCHOY9OigZ+1dV2iaRJWF3dFNdzuaPxx+X7j5M9nVPDl6n5z
         T3tK6luCqjuU0Ibyy5rvMfcc7jZy+Z/gsIufM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e1YZSnr+tf37urRS0Z3ujXsrRMc5cw+9H7NAi1i2jVA=;
        b=KkQRBzSqH45UcjCD69LSYw0NLLDe/NbUQVRJeZyEmOEu6CHA2rVEherWz0PE5+zbgv
         Slztc3tGPNkQ+NCWJMuU+c6GOo9PmA4F5E4USWhQJRy8fGyHz0oOz+0aA9vObCfkKqyN
         tVAt2lQssyxq69MarBiQdFdNCtj8WuUSLYTzbjhzFL/C0r8+ROE6QoLLiqaNGKbIHZEq
         1y9Ok67NSuPK4ol844817IvqqAJ/N6sw9x+sGWRCKBPa59dX6QOaEcpBqXTu0vAOpA3L
         GCUk6Fggd3DYQ9w7nHofro22uEuA0OghjTocg8NfLejZr6alcNbTb6UEjObujkM6jM4L
         P3zw==
X-Gm-Message-State: APjAAAWS7PTlh2uHdcamOCAeIZYnUXpGnidpfL7Suz90rFJ1PCSo8J++
        4K3EzHObUlpSKmnzXoSoxYs9AA==
X-Google-Smtp-Source: APXvYqzOHOGfFvHHv3LUcDdUgo528S5MG4NnAaB5IQ1fyDZOtJwryOAp83caQNAMb12Fx3S0UUC80Q==
X-Received: by 2002:a17:902:8f92:: with SMTP id z18mr9844183plo.230.1570726048308;
        Thu, 10 Oct 2019 09:47:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h68sm8085569pfb.149.2019.10.10.09.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 09:47:27 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:47:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/29] vmlinux.lds.h: Allow EXCEPTION_TABLE to live in
 RO_DATA
Message-ID: <201910100947.AC066B160@keescook>
References: <20190926175602.33098-1-keescook@chromium.org>
 <20190926175602.33098-15-keescook@chromium.org>
 <20191010152516.GG7658@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010152516.GG7658@zn.tnic>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Oct 10, 2019 at 05:25:16PM +0200, Borislav Petkov wrote:
> On Thu, Sep 26, 2019 at 10:55:47AM -0700, Kees Cook wrote:
> > Many architectures have an EXCEPTION_TABLE that needs only to be
> > read-only. As such, it should live in RO_DATA. This creates a macro to
> > identify this case for the architectures that can move EXCEPTION_TABLE
> > into RO_DATA.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index d57a28786bb8..35a6cba39d9f 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -69,6 +69,17 @@
> >  #define NOTES_HEADERS_RESTORE
> >  #endif
> >  
> > +/*
> > + * Some architectures have non-executable read-only exception tables.
> > + * They can be added to the RO_DATA segment by specifying their desired
> > + * alignment.
> > + */
> > +#ifdef RO_DATA_EXCEPTION_TABLE_ALIGN
> > +#define RO_DATA_EXCEPTION_TABLE	EXCEPTION_TABLE(RO_DATA_EXCEPTION_TABLE_ALIGN)
> > +#else
> > +#define RO_DATA_EXCEPTION_TABLE
> > +#endif
> > +
> >  /* Align . to a 8 byte boundary equals to maximum function alignment. */
> >  #define ALIGN_FUNCTION()  . = ALIGN(8)
> >  
> > @@ -508,6 +519,7 @@
> >  		__stop___modver = .;					\
> >  	}								\
> >  									\
> > +	RO_DATA_EXCEPTION_TABLE						\
> >  	NOTES								\
> >  									\
> >  	. = ALIGN((align));						\
> > -- 
> 
> I think you can drop the "DATA" from the names as it is kinda clear
> where the exception table lands:
> 
> RO_EXCEPTION_TABLE_ALIGN
> RO_EXCEPTION_TABLE
> 
> The "read-only" part is the important one.

Excellent point; I was not loving the how long the name was either. :)

-- 
Kees Cook
