Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2CC1C700C
	for <lists+linux-s390@lfdr.de>; Wed,  6 May 2020 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgEFMMk (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 6 May 2020 08:12:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45743 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbgEFMMj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 08:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588767157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybp99ie0cZbrJsaPu3fRVqjLiBB0hnNYN5fy/Wmj9SE=;
        b=FUe2Gp1OdbhQN8IByVbTZ4n+2tTMF8ATm+a4A7CHftOpbf0bom+puDGXQq6w5SNbfDVXFT
        gwHqc+VKRHdeASY8u9tvZZLQsj3HUlub2Mb/MiRUaPYlLxw3G4ySVLazzczA8QeoThMBgk
        NZCnTbeg0zJNbXY1IbsyW8AeeIV6RdQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-ASP4sSG_MO-6D6AqWg8IIA-1; Wed, 06 May 2020 08:12:35 -0400
X-MC-Unique: ASP4sSG_MO-6D6AqWg8IIA-1
Received: by mail-wm1-f71.google.com with SMTP id h184so1119727wmf.5
        for <linux-s390@vger.kernel.org>; Wed, 06 May 2020 05:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ybp99ie0cZbrJsaPu3fRVqjLiBB0hnNYN5fy/Wmj9SE=;
        b=TGJGI2jhmiU6RaP7tTobf1gBzia3TVF6YJfhve3djOsQr180wpj4AKLyapdrdLDNmj
         mjdAK0jmpLBBnqfXKIEeyxBlDzaxJ9AbHnr+fRcDhedhLeDzEW6qO/OIi6gsTFWhG7/B
         TQkPbVrAc7glaVQ+m3M5PbCp9tPJNgegxPlJCtnkYGMmv27M+GM517k/msQMylO9HHZi
         b/rR/ShZhOkzatxGh5MrzMl1RihtIS17ZHGKhoZZ9ynyICl6fTFql2r4FpONquY6xqxw
         TEFrRxb8S0m+NCA2a5Qr8OlhMepbc1YL05BXFsR57ElIoRdT+uR4uySlbGpVJ0nW4w0q
         Zl7A==
X-Gm-Message-State: AGi0Pub+cHAIEo7ftKkfCbhrZjj/Dx48qAPU8yZw9DahqGU0EwCcImRz
        NwXCEsdTUO1aolw6DLxx2HIb7ImpMneFn+yEuH+QnSKfU+KWqZhHjXekhiklyPaOZiIct2gp8oB
        4lJOfec4e1XHQKKinQq+7yw==
X-Received: by 2002:a1c:6402:: with SMTP id y2mr4149169wmb.116.1588767151386;
        Wed, 06 May 2020 05:12:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypKA0dkO+kUYpZP4gWFbcPSl/DNfe0d39YUqIA7R6bHmLSW3U7w+KDm1VQ6rvIbX7CmDagIXNA==
X-Received: by 2002:a1c:6402:: with SMTP id y2mr4149141wmb.116.1588767150993;
        Wed, 06 May 2020 05:12:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11d7:2f21:f38b:17e? ([2001:b07:6468:f312:11d7:2f21:f38b:17e])
        by smtp.gmail.com with ESMTPSA id p190sm2745441wmp.38.2020.05.06.05.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 05:12:30 -0700 (PDT)
Subject: Re: [GIT PULL 1/1] KVM: s390: Remove false WARN_ON_ONCE for the PQAP
 instruction
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Qian Cai <cailca@icloud.com>
References: <20200506115945.13132-1-borntraeger@de.ibm.com>
 <20200506115945.13132-2-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bcd98cbd-1e28-47a2-6cbd-668da4ddb9f5@redhat.com>
Date:   Wed, 6 May 2020 14:12:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200506115945.13132-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06/05/20 13:59, Christian Borntraeger wrote:
> Running nested under z/VM can result in other intercepts as
> well as ECA_APIE is an effective bit: If one hypervisor layer has
> turned this bit off, the end result will be that we will get intercepts for
> all function codes. Usually the first one will be a query like PQAP(QCI).
> So the WARN_ON_ONCE is not right. Let us simply remove it.

Possibly stupid question since I can only recognize some words here. :)
But anyway... shouldn't z/VM trap this intercept when the guest has
turned off the bit, and only reflect the SIE exit based on the function
code?

Thanks,

Paolo

