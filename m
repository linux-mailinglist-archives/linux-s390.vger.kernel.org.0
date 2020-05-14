Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263531D388C
	for <lists+linux-s390@lfdr.de>; Thu, 14 May 2020 19:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgENRnD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 14 May 2020 13:43:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22965 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbgENRnC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 May 2020 13:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589478180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5sDx7dFYVPQq/9gZnVKC9PwVBjvUUzuU4UJpJeg6i4=;
        b=JQIAFXBFqQ6sPZwbxBiDTC5ChEq/oay+lOglPSx+JW72Re7FNaJIVQ4Ns+7bv9i8LcAdpU
        plyPa2u1WhyWZFr2rBZEnzq8F5MYSfZbGqWi5rORGTsT3QQsymJgCX9Pa9ze122jbQtFNA
        OW5S6+g2OZ9nsF0TJ/h0ss+NygaCLDE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-ZiGYlV4XOiuFOnRY_nxhuw-1; Thu, 14 May 2020 13:42:58 -0400
X-MC-Unique: ZiGYlV4XOiuFOnRY_nxhuw-1
Received: by mail-wm1-f69.google.com with SMTP id m123so7102944wmm.5
        for <linux-s390@vger.kernel.org>; Thu, 14 May 2020 10:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D5sDx7dFYVPQq/9gZnVKC9PwVBjvUUzuU4UJpJeg6i4=;
        b=gUxxC2M6RXPvTW70o1AeRTl1/cc7nLj9+tFDoRvyCaTGIiHnjvogmMjhzxmV+3TqJe
         q4nGPCOFuR+WpnqTVxSz7adDSRcvXd8uBa0oWHvWgGrWWPXkA+K0yss+ZfNxYEFZ6SUd
         KVgdt0amGTbCRC1QtBnVSz4hn6mXeH68AhFGyokl6Boqjbp0VRobxgcUd9WZO4XR5nBF
         6/s/5jJHPtXE0Bxd8QnoMJ4tSB80j59c637oWcC3VofAXMyxuixaoF40yiOyk9loXTng
         xG77XwauCk6hp39m9SDKNwm4bAW8JmdUktVqW9PMtezoQoOw4F+NHKgBrNv6rb8wv4rZ
         9wOQ==
X-Gm-Message-State: AGi0PuaLsjj6K2M9Z53s2BmrdwzByzFY3mAqXVgIyoVYYhReFqaUpjbb
        JiJ40PgV4vYvYFjKlMEgNkZ+Wm2f5hB7AxJdECTVfFHR8YjOIRXrEOfTUa4T0qxR+ainnKrLtV1
        DWJjD97Jr8X/Q9K1z3OwnpQ==
X-Received: by 2002:a1c:3182:: with SMTP id x124mr53013506wmx.54.1589478177800;
        Thu, 14 May 2020 10:42:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypLHsxLGQ9nhYmAh9ZrOpDofZG0BF1DYUCQUcdUAHKdJA5OS/syMmvoJESfLmoWjrDK3d7BTww==
X-Received: by 2002:a1c:3182:: with SMTP id x124mr53013466wmx.54.1589478177392;
        Thu, 14 May 2020 10:42:57 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.85.171])
        by smtp.gmail.com with ESMTPSA id d126sm22211297wmd.32.2020.05.14.10.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 10:42:56 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
To:     Jonathan Adams <jwadams@google.com>
Cc:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200504110344.17560-1-eesposit@redhat.com>
 <CA+VK+GN=iDhDV2ZDJbBsxrjZ3Qoyotk_L0DvsbwDVvqrpFZ8fQ@mail.gmail.com>
 <29982969-92f6-b6d0-aeae-22edb401e3ac@redhat.com>
 <CA+VK+GOccmwVov9Fx1eMZkzivBduWRuoyAuCRtjMfM4LemRkgw@mail.gmail.com>
 <fe21094c-bdb0-b802-482e-72bc17e5232a@redhat.com>
 <CA+VK+GOnVK23X+J-VVWUK6VVpkeVOvsmQAw=HAf89h_ksYM9Rg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ec17c313-d95c-d41f-5852-d7d3637e1ad5@redhat.com>
Date:   Thu, 14 May 2020 19:42:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+VK+GOnVK23X+J-VVWUK6VVpkeVOvsmQAw=HAf89h_ksYM9Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14/05/20 19:35, Jonathan Adams wrote:
>> In general for statsfs we took a more explicit approach where each
>> addend in a sum is a separate stats_fs_source.  In this version of the
>> patches it's also a directory, but we'll take your feedback and add both
>> the ability to hide directories (first) and to list values (second).
>> 
>> So, in the cases of interfaces and KVM objects I would prefer to keep
>> each addend separate.
>
> This just feels like a lot of churn just to add a statistic or object;
> in your model, every time a KVM or VCPU is created, you create the N
> statistics, leading to N*M total objects.

While it's N*M files, only O(M) statsfs API calls are needed to create
them.  Whether you have O(N*M) total kmalloc-ed objects or O(M) is an
implementation detail.

Having O(N*M) API calls would be a non-started, I agree - especially
once you start thinking of more efficient publishing mechanisms that
unlike files are also O(M).

>> For CPUs that however would be pretty bad.  Many subsystems might
>> accumulate stats percpu for performance reason, which would then be
>> exposed as the sum (usually).  So yeah, native handling of percpu values
>> makes sense.  I think it should fit naturally into the same custom
>> aggregation framework as hash table keys, we'll see if there's any devil
>> in the details.
>>
>> Core kernel stats such as /proc/interrupts or /proc/stat are the
>> exception here, since individual per-CPU values can be vital for
>> debugging.  For those, creating a source per stat, possibly on-the-fly
>> at hotplug/hot-unplug time because NR_CPUS can be huge, would still be
>> my preferred way to do it.
> 
> Our metricfs has basically two modes: report all per-CPU values (for
> the IPI counts etc; you pass a callback which takes a 'int cpu'
> argument) or a callback that sums over CPUs and reports the full
> value.  It also seems hard to have any subsystem with a per-CPU stat
> having to install a hotplug callback to add/remove statistics.

Yes, this is also why I think percpu values should have some kind of
native handling.  Reporting per-CPU values individually is the exception.

> In my model, a "CPU" parameter enum which is automatically kept
> up-to-date is probably sufficient for the "report all per-CPU values".

Yes (or a separate CPU source in my model).

Paolo

> Does this make sense to you?  I realize that this is a significant
> change to the model y'all are starting with; I'm willing to do the
> work to flesh it out.


> Thanks for your time,
> - Jonathan
> 
> P.S.  Here's a summary of the types of statistics we use in metricfs
> in google, to give a little context:
> 
> - integer values (single value per stat, source also a single value);
> a couple of these are boolean values exported as '0' or '1'.
> - per-CPU integer values, reported as a <cpuid, value> table
> - per-CPU integer values, summed and reported as an aggregate
> - single-value values, keys related to objects:
>     - many per-device (disk, network, etc) integer stats
>     - some per-device string data (version strings, UUIDs, and
> occasional statuses.)
> - a few histograms (usually counts by duration ranges)
> - the "function name" to count for the WARN statistic I mentioned.
> - A single statistic with two keys (for livepatch statistics; the
> value is the livepatch status as a string)
> 
> Most of the stats with keys are "complete" (every key has a value),
> but there are several examples of statistics where only some of the
> possible keys have values, or (e.g. for networking statistics) only
> the keys visible to the reading process (e.g. in its namespaces) are
> included.
> 

