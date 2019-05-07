Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037AE16C53
	for <lists+linux-s390@lfdr.de>; Tue,  7 May 2019 22:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfEGUiz (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 7 May 2019 16:38:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43146 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfEGUiz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 May 2019 16:38:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id i8so6560614oth.10
        for <linux-s390@vger.kernel.org>; Tue, 07 May 2019 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6pfRHejW3cZFOE77y3IUUX4go4AGbYiRoY6juBt94WE=;
        b=n2cLf9QvpatFw6Fx6Im50C3lqxaAWG43jr2hC2ev1xZpfJ6J8FUzxhXEUavTl94SZm
         SVHlKHKIcM/ZhfovCw4MijKPgzW/E+HLz4qZ175x7tfNV+dQC05A0tETwYssL7clan9W
         UsEpcZNB+TJeQSbZEqorEcfiOUdbu+Sy8m9YAZ3S+el0grhl2bD78JddE66O4Q+1avuY
         KR225hZ12kjGn4PRHpeZLqKoFnuS+tJCq4z76VyCpIv4O/vr+Au5mfwKYyPGTxiEapDr
         R3GKFkX289EisuP8nBoU3VOoPxvd3l0FVJ+ulJz6IltOlc4nobKQXXstnEsx5ZFdmsTb
         rEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pfRHejW3cZFOE77y3IUUX4go4AGbYiRoY6juBt94WE=;
        b=h0F++fSbbWdQBJFklPITQ8imEsEzYbuH7eih9MfNCparXxdBIDbkjyfyqn9BfpMQ/p
         jf1C4vtlWCq2k+AvazmQSqlOp4ZH4+/jM8hawBFTZ7iiHaf7EY+mhKHcXSiGjT2xCjNL
         nXtrVgPh9ledI6sOzijAy5Iq18ySb/J7enXRz7bJA93AA9mGLgFtkUHOjGoROkjdrmAq
         Oje++s/wuPxmvO7qwcz0fE2E2DokjCothNDYoX6yJqN9SFY+gsZe3vvvZZ1P+hc+YFcW
         CtE2x58XRunIbMbyooCFx3rlmFPeuTByNcDxsVho3oNzdJNyCRNBWlBxc1raMqCoCBiq
         XmTw==
X-Gm-Message-State: APjAAAUTI0CgzdXTcL3wenyRAdKleaiIIWQnOugO7zuAoHA0yb0Isd9m
        Cg3J0ppe/TtZNPhrj66EDTBrnoe7y3ZwqMQySAQRXg==
X-Google-Smtp-Source: APXvYqyoyS46mGkeS8xfe2+s5llXVwHTTrq4TjXi1ZN6I2Su0aHjvxJMNj2Psjrwn9yCamOWlD6+DD7mFrLZ6kZfD1Q=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr21322434oti.229.1557261534468;
 Tue, 07 May 2019 13:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190507183804.5512-1-david@redhat.com> <20190507183804.5512-2-david@redhat.com>
In-Reply-To: <20190507183804.5512-2-david@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 May 2019 13:38:43 -0700
Message-ID: <CAPcyv4jCtOYLCtAhRPhGrHZKyvHZmE8i1aGsRRBWk+G0v4EGAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] mm/memory_hotplug: Simplify and fix check_hotplug_memory_range()
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Qian Cai <cai@lca.pw>, Wei Yang <richard.weiyang@gmail.com>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 7, 2019 at 11:38 AM David Hildenbrand <david@redhat.com> wrote:
>
> By converting start and size to page granularity, we actually ignore
> unaligned parts within a page instead of properly bailing out with an
> error.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
