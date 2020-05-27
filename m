Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C881E4322
	for <lists+linux-s390@lfdr.de>; Wed, 27 May 2020 15:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbgE0NOt (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 27 May 2020 09:14:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24737 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387645AbgE0NOs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 May 2020 09:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590585287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xp4IU27b7aXZqohMpJFZPawUcolyfH/CQm0FvETLmFY=;
        b=RQBhO4RyGmtftVuECLdSRL1cootwbRQuswQ9bmUojLtEP0hcYVKcfwIYJR3HFuiPa0dw74
        W+xmaI1rR7U8qA+AYSbA/S0Ghg+1xtx8ZShdNuF0LheUsv+Ofhh55aJdphDb72G407fKVR
        6o8ftQ4DdCK+nT3IF1xpTWcyXe2a57Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-8IdVuVwzNwC3OS2_sN-qLg-1; Wed, 27 May 2020 09:14:45 -0400
X-MC-Unique: 8IdVuVwzNwC3OS2_sN-qLg-1
Received: by mail-wr1-f70.google.com with SMTP id h6so10417332wrx.4
        for <linux-s390@vger.kernel.org>; Wed, 27 May 2020 06:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xp4IU27b7aXZqohMpJFZPawUcolyfH/CQm0FvETLmFY=;
        b=PiX4W6WErPLAyQZGvi8+A7TpDff5euI11qOOT8U/f/M22GqKTAnSer7gUTzdVM2mfd
         2JGX6BLwZE32lwaBVw6gX/AK31oOzkQoXSda4jTvI+Ncac87iIzABCFHYXcbAXErCfIf
         uB/NAICixpEZkrjnT89bZhn/yUEg8QFMWRHhvNUHCcnH2oHUyTwR+7pQsKU0Op4P8o9J
         JkSpdpr4IJfXQ9cDoUb73HOai17R2w7x98v3DddlPzVm7k8Y7TepB/Tp2g3Wt24Pq0pW
         zIT5HEo2w6KEFNc2RzK8cq4fu/ptxNQyPs/gF1vlzUe7OavcFn/EUhg5VaxwhM+i1Je4
         8Ojg==
X-Gm-Message-State: AOAM531psPZSAyDedNwc1K/Zo7y9OhKzZevQ22s8/NfBRxdulQ6t7VJo
        3uBbF8D89qdA2j2OjcK+FycizCfPhC09uI6/VMInmEFwVcM51qxIwBexX5nnBUK0yrHwbaIlsHJ
        HYiQ9dJgg86dUlaQO9wpFQg==
X-Received: by 2002:a1c:1b17:: with SMTP id b23mr4189539wmb.3.1590585284255;
        Wed, 27 May 2020 06:14:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXDD9pd6xDx85wKJ6DSUd0+jHdsTLXsbOgS1BfL3siVJ+UTokB2SEyRQkeYWpyFjB2Klsulg==
X-Received: by 2002:a1c:1b17:: with SMTP id b23mr4189496wmb.3.1590585283890;
        Wed, 27 May 2020 06:14:43 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.225])
        by smtp.gmail.com with ESMTPSA id r4sm2825862wro.32.2020.05.27.06.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 06:14:43 -0700 (PDT)
Subject: Re: [PATCH v3 0/7] Statsfs: a new ram-based file system for Linux
 kernel statistics
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
References: <20200526110318.69006-1-eesposit@redhat.com>
 <20200526153128.448bfb43@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <6a754b40-b148-867d-071d-8f31c5c0d172@redhat.com>
Date:   Wed, 27 May 2020 15:14:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526153128.448bfb43@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


>>
>> The file system is mounted on /sys/kernel/stats and would be already used
>> by kvm. Statsfs was initially introduced by Paolo Bonzini [1].
> 
> What's the direct motivation for this work? Moving KVM stats out of
> debugfs?

There's many reasons: one of these is not using debugfs for statistics, 
but also (and mainly) to try and have a single tool that automatically 
takes care and displays them, instead of leaving each subsystem "on its 
own".

Sure, everyone gathers and processes stats in different ways, and the 
aim of this tool is to hopefully be extensible enough to cover all needs.
> In my experience stats belong in the API used for creating/enumerating
> objects, statsfs sounds like going in the exact opposite direction -
> creating a parallel structure / hierarchy for exposing stats.

  I know
> nothing about KVM but are you sure all the info that has to be exposed
> will be stats?I don't understand, what do you mean here?

> 
> In case of networking we have the basic stats in sysfs, under the
> netdevice's kobject. But since we're not using sysfs much any more
> for config, new stats are added in netlink APIs. Again - same APIs
> used for enumeration and config.

I don't really know a lot about the networking subsystem, and as it was 
pointed out in another email on patch 7 by Andrew, networking needs to 
atomically gather and display statistics in order to make them 
consistent, and currently this is not supported by stats_fs but could be 
added in future.

In addition, right now it won't work properly if the networking 
namespaces are enabled. That is another issue to take into 
consideration. That's also why I marked patch 7 as "not for merge"

Regarding the config, as I said the idea is to gather multiple 
subsystems' statistics, therefore there wouldn't be a single 
configuration method like in netlink.
For example in kvm there are file descriptors for configuration, and 
creating them requires no privilege, contrary to the network interfaces.

Thank you,
Emanuele

