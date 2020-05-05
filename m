Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD86E1C5E41
	for <lists+linux-s390@lfdr.de>; Tue,  5 May 2020 19:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgEERCn (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 5 May 2020 13:02:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22243 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730608AbgEERCn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 13:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588698161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wA5G//ZMwKX3KXqf3Mv3pq9KAcUMr/otngiqdWE/rQ=;
        b=f4hBZdIT0fUnLr5YIdT3hLEZeAoQrnGo6S+77a3aO79CES/aHHUeGTvBWQrfFvtQYTVTdy
        wc9yr6tDjCKhTzWXaR69f4t4T4CgkwQck7aQr2QX9ozqModWk8pSOQDvSBRWhJODBJkh5W
        e0byfBrLLt4Vh6gywoGnMV4wXiUAmMQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-9ZSdmtedO_OYC8QzdQaagg-1; Tue, 05 May 2020 13:02:38 -0400
X-MC-Unique: 9ZSdmtedO_OYC8QzdQaagg-1
Received: by mail-wr1-f72.google.com with SMTP id g7so1515123wrw.18
        for <linux-s390@vger.kernel.org>; Tue, 05 May 2020 10:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5wA5G//ZMwKX3KXqf3Mv3pq9KAcUMr/otngiqdWE/rQ=;
        b=W4H9MMMT6suEH7JCj7rcDmLhekvcxh2y7k44Iffwz5U+xD1kEjDZq+/SvzujqPAT5N
         sqhbFpZ4U3gXBqqWGQxP1XMaPeIWuIDOAsoQro7yNzf1KvHQNx0Ips+NrX94kqxA3zyi
         Gi5v6XuZkAk96Pf9/tvSypltwgWJcBLfYsTKxpZuIC+bukDuYBJplrZsG0uowFFCtu/q
         VUGyX5sjwitx/1qg3CQBINAuO2wPx8+45qVRCfkeNGSKKV+3761zvujFJOZXXo/GhPaR
         YAvAhbc2Dip5NS/MIYX1/m9D6RHMF2JaJGRoLcwmPpdzgVXou5KimaR4wazOHk0KtgcD
         Svww==
X-Gm-Message-State: AGi0PubbBLzD2m/0uGMy5Ggi6M/9QqiDfk+t090heqTJDBS80NuAfW7R
        h8FbQGyCP60isUFblo2QA3z/g/DoaZ1UOqa/BAU81Go//0vezzqLgxFq2bgj6L+Y2BgjwrVKpj0
        yAst+KxgPwC1yVuqesXJYRw==
X-Received: by 2002:adf:d0c5:: with SMTP id z5mr5096747wrh.410.1588698156792;
        Tue, 05 May 2020 10:02:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypJLNwomNOVHwIvpSDnSwZmv6Omr127dtUlNqUvacYqezIg5AT62IcLqVfdIy2Hep5WWyqsAoA==
X-Received: by 2002:adf:d0c5:: with SMTP id z5mr5096701wrh.410.1588698156541;
        Tue, 05 May 2020 10:02:36 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id g24sm1632241wrb.35.2020.05.05.10.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 10:02:35 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
To:     Jim Mattson <jmattson@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     David Rientjes <rientjes@google.com>,
        Jonathan Adams <jwadams@google.com>,
        kvm list <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20200504110344.17560-1-eesposit@redhat.com>
 <alpine.DEB.2.22.394.2005041429210.224786@chino.kir.corp.google.com>
 <f2654143-b8e5-5a1f-8bd0-0cb0df2cd638@redhat.com>
 <CALMp9eQYcLr_REzDC1kWTHX4SJWt7x+Zd1KwNvS1YGd5TVM1xA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1d12f846-bf89-7b0a-5c71-e61d83b1a36f@redhat.com>
Date:   Tue, 5 May 2020 19:02:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQYcLr_REzDC1kWTHX4SJWt7x+Zd1KwNvS1YGd5TVM1xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/05/20 18:53, Jim Mattson wrote:
>>> Since this is becoming a generic API (good!!), maybe we can discuss
>>> possible ways to optimize gathering of stats in mass?
>> Sure, the idea of a binary format was considered from the beginning in
>> [1], and it can be done either together with the current filesystem, or
>> as a replacement via different mount options.
> 
> ASCII stats are not scalable. A binary format is definitely the way to go.

I am totally in favor of having a binary format, but it should be
introduced as a separate series on top of this one---and preferably by
someone who has already put some thought into the problem (which
Emanuele and I have not, beyond ensuring that the statsfs concept and
API is flexible enough).

ASCII stats are necessary for quick userspace consumption and for
backwards compatibility with KVM debugfs (which is not an ABI, but it's
damn useful and should not be dropped without providing something as
handy), so this is what this series starts from.

Paolo

