Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4B82B82A2
	for <lists+linux-s390@lfdr.de>; Wed, 18 Nov 2020 18:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgKRRFY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 18 Nov 2020 12:05:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727207AbgKRRFY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 12:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605719122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g2Sa7Dk+sRaVjGw/kocptUkYSTQ4KlbBdgTfGZ6iYVI=;
        b=iNFwhgl5AWMjNRFSzpZlyWjpQQnETWYq80h3Th0QNe73yG3MDqu8G0rsJr+w1sPZ8SO8bQ
        0vlWHBhhd198kvOrQSaZD0EPb+hLziXo351bT8bMpF+NL7dguHm1q9gydIqdPDP67GQ4qK
        s5pDNE3dj3bOr7JoC3bUJ/i3d7LY3Rs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-rv-iilJ6OduP-qG9q2BQag-1; Wed, 18 Nov 2020 12:05:21 -0500
X-MC-Unique: rv-iilJ6OduP-qG9q2BQag-1
Received: by mail-ed1-f70.google.com with SMTP id x15so1061237edr.10
        for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2020 09:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g2Sa7Dk+sRaVjGw/kocptUkYSTQ4KlbBdgTfGZ6iYVI=;
        b=VHVtm1+hMFXZdmqQCUnqCQWzokyVZQv/EkazKUK2K1Cf3zj5VUYacMzHE6jbVDccZH
         76O8flGvOis3UG4YgiUiRBJrVndG2dlnQKmVaLPSp+fVycgECVrj8rXZqg7Dwy+ek+XN
         XQrdWR7jFbMYX+dGZ0xY3Fmp/1URG9nO07YbeWQ+5+C7jzfxhBgRdMMRDmo9FClvTaIV
         v/Pc6cVFluoEOwo+8fWHYzq7yfC+4K4pM9D728+zQCUU3gGSdj+Rl2gaiUiKFo704cFJ
         dHg9NjpUXAJ30hAyhZFmgqUx1Crz1Sx9g7Q5X8qqfH3pAYLLXcpF3ikMgl8pfCazvX4C
         CVFw==
X-Gm-Message-State: AOAM532wAcC6qQGL7YVAEfeIydv6VVh1x6D1msQa3uhnTqEFrrEeeexO
        vkidWN7bOLabSemsMdQy8sZtdWSE5kXZdl6ZBaIOuBmjBb+olzjPr8bERYwkVqEgq83IHpCGeFB
        BwLxYsNWKt8CyDFee5uNAPus750fB0QKPyFwxS3CdNt7EB2jEYxwrr96/eSnIMH22KoH67DrxJA
        ==
X-Received: by 2002:aa7:d1c6:: with SMTP id g6mr26334340edp.130.1605719119207;
        Wed, 18 Nov 2020 09:05:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgwh2sv6DLtuw6oIcxYVFRbTJQEgIArwhuwYd5WcEHzJokzEqwDN8h59ePpZ8Kvx8efo3nCg==
X-Received: by 2002:aa7:d1c6:: with SMTP id g6mr26334287edp.130.1605719118783;
        Wed, 18 Nov 2020 09:05:18 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u15sm5518502edt.24.2020.11.18.09.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 09:05:17 -0800 (PST)
Subject: Re: [GIT PULL 0/2] KVM: s390: Fix for destroy page ultravisor call
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <20201118170116.8239-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e6ed560-9e75-e596-174b-8f10a078c761@redhat.com>
Date:   Wed, 18 Nov 2020 18:05:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201118170116.8239-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18/11/20 18:01, Christian Borntraeger wrote:
> Paolo,
> 
> one more fix for 5.10 in addition with an update of the MAINTAINERS
> file. The uv.c file is mostly used by KVM and Heiko asked that we take
> care of this patch.
> 
> The following changes since commit 6cbf1e960fa52e4c63a6dfa4cda8736375b34ccc:
> 
>    KVM: s390: remove diag318 reset code (2020-11-11 09:31:52 +0100)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.10-2
> 
> for you to fetch changes up to 735931f9a51ab09cf795721b37696b420484625f:
> 
>    MAINTAINERS: add uv.c also to KVM/s390 (2020-11-18 13:09:21 +0100)
> 
> ----------------------------------------------------------------
> KVM: s390: Fix for destroy page ultravisor call
> 
> - handle response code from older firmware
> - add uv.c to KVM: s390/s390 maintainer list
> 
> ----------------------------------------------------------------
> Christian Borntraeger (2):
>        s390/uv: handle destroy page legacy interface
>        MAINTAINERS: add uv.c also to KVM/s390
> 
>   MAINTAINERS           | 1 +
>   arch/s390/kernel/uv.c | 9 ++++++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 

Pulled, thanks.

Paolo

