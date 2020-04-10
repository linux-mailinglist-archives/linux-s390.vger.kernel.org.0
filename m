Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D60F1A4A7A
	for <lists+linux-s390@lfdr.de>; Fri, 10 Apr 2020 21:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgDJTe0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 10 Apr 2020 15:34:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22022 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgDJTeZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Apr 2020 15:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586547265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dR0pnT92lTl7PiXH1/vycyqLlKqG/upjftJ1HpISkMA=;
        b=B23qFvRBondG0uk3w1fbnTLyduYxESk9W7GeV7pwe9WbgI6HE/bFVpdfNa3on7+sN1pK8h
        LcPdyQaB57XZ/zwtG8bvuKP+TO0DlkbYxav7BHuz1pp2pEmGo/vgkCFS9YbJXSYiLEqrSQ
        9powbFokcNRGcMRh9lWnVZJg96aubR8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-UvGL34ovNKaOeJDhiJMsxQ-1; Fri, 10 Apr 2020 15:34:23 -0400
X-MC-Unique: UvGL34ovNKaOeJDhiJMsxQ-1
Received: by mail-qt1-f197.google.com with SMTP id j7so2672238qtd.22
        for <linux-s390@vger.kernel.org>; Fri, 10 Apr 2020 12:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dR0pnT92lTl7PiXH1/vycyqLlKqG/upjftJ1HpISkMA=;
        b=Fr4qj9M4np/bkCOi8dJPEPtuDZ6vgwls9nBS+gk9UyThzkVopM8q2cFpWYbMritHTT
         pR0fTmQTHnB3pLibHEoQ8nADdbfFIJlY9c9jqBbFFAZnUM0eDS3O5sziWxZhSkE2Vxo8
         mCPlC2UnDQUOrKe/4/Zz5ZLJv8kgtigcHimhAvd3bTVuveJoe+lqNZVZ45bg1iu69i2Y
         mXBikGgSmjqqfXCRxI3MUVIoYupzwWxqip1OrBJ59lDtAFxdKIngO4r4tJtz+17Z4Fx7
         y3KXw2i0lHRpuw/3bKQl7fWUgW6HmY5spTX6AJ8oDbINJKpirkKBobXF4gkBra1RCoR9
         6zgg==
X-Gm-Message-State: AGi0PuYcHDDKh1TIaW6xykIlDD1iq3WXNqa3G4Ket+OSMosdvCLcR6R6
        AV2+Xb3klUekZUde8uRpuw1fSYpsoqTHgunxCvB0LzmIYnO5rU4U+Fvv+IVD51IruUdEZq4X7HC
        ayCdnG0U8EezLYTq46dyKOQ==
X-Received: by 2002:ac8:6d06:: with SMTP id o6mr768733qtt.165.1586547263228;
        Fri, 10 Apr 2020 12:34:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypKE+9gdKAAzqM7E075abKl7yEhzpSisddiPAFgdbjLHprLwAVDEdymEnBo0qMB8GT4NFqVJjg==
X-Received: by 2002:ac8:6d06:: with SMTP id o6mr768725qtt.165.1586547263017;
        Fri, 10 Apr 2020 12:34:23 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id m11sm2214328qkg.130.2020.04.10.12.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 12:34:22 -0700 (PDT)
Date:   Fri, 10 Apr 2020 15:34:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Longpeng <longpeng2@huawei.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 3/4] hugetlbfs: remove hugetlb_add_hstate() warning
 for existing hstate
Message-ID: <20200410193419.GF3172@xz-x1>
References: <20200401183819.20647-1-mike.kravetz@oracle.com>
 <20200401183819.20647-4-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200401183819.20647-4-mike.kravetz@oracle.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Apr 01, 2020 at 11:38:18AM -0700, Mike Kravetz wrote:

[...]

> @@ -3255,7 +3254,6 @@ void __init hugetlb_add_hstate(unsigned int order)
>  	unsigned long i;
>  
>  	if (size_to_hstate(PAGE_SIZE << order)) {
> -		pr_warn("hugepagesz= specified twice, ignoring\n");
>  		return;
>  	}

Nitpick: I think the brackets need to be removed to follow linux
coding style.  With that:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

