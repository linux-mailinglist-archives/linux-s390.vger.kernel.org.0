Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9F51C700E
	for <lists+linux-s390@lfdr.de>; Wed,  6 May 2020 14:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgEFMMz (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 6 May 2020 08:12:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53052 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727777AbgEFMMz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 08:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588767173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mGKAKOoXib9J9GLorrHt4wp5oK180n6GKU4cMIBxKAk=;
        b=ghtnjkgZNK2XbAUMg523to90Xwa2RkGym+WexWVA3YeEgBxbJFguxG9Q34y9W0vKqWMx90
        jrA55WpiKwXwdcwQHnwNla7uakKE57X9TYCE5qJgil1dUHpJ3r4oJE8YcPXBHcEdn89ejn
        c/PLvKiUeSAIxCn2WMhS/CKK6kCugXE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-HWQU86QxPhKcaRpsl8DhYw-1; Wed, 06 May 2020 08:12:52 -0400
X-MC-Unique: HWQU86QxPhKcaRpsl8DhYw-1
Received: by mail-wm1-f71.google.com with SMTP id 14so673671wmo.9
        for <linux-s390@vger.kernel.org>; Wed, 06 May 2020 05:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mGKAKOoXib9J9GLorrHt4wp5oK180n6GKU4cMIBxKAk=;
        b=UESwIRszjDS9D9L+Ik6ehwlcthAsHea1u1kYE9JgmOTMFn1vdVWWuego69GtmG2u8M
         LuENi6nxEkoXqzGUyZj7Yg8ku7Yt7292mfB75I0IhP5Wg/niVgaMuHZfuO98W/ZWaZKH
         q5cgzhWl9en3ECQK1t9TbupUhg2IQ4RJNDWDJPlazDvtNl9YI2iuz3Orzz8lyV6TrzYU
         RkZ7wLBdsfy7muPGPRuJ4LnqlXzXUF5BKUaUGr23CxJ+gzjZYEsA347mEW4IoGGZ/w1T
         kmVMdMiLb6D+XmSzzOzYc5//m3lhKfTG82mUo0+07MyWtwYO55JZ+UQZIA1hSHJtwuyL
         kFkw==
X-Gm-Message-State: AGi0PuZpz1ooXc8J019ASiYb0y1IaavNKj97dvIlC2ARkOz6qNo8zu/U
        p51sq/iEidS1HerWzMJN7ynkGTxgj8C6a0Ny6wAYKYMNeBB7hSbKh9MpvyxeACcpUrWozB05BEN
        PXhpbAAxacwfFsJfSJlwcIg==
X-Received: by 2002:a1c:5403:: with SMTP id i3mr4520788wmb.10.1588767170595;
        Wed, 06 May 2020 05:12:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypKzFzMB1AUH6OYu+u4u9EhJqeki41lDE4NjZD/BfMex3GyyxvZlvlNEqY2FSNPFuCVgRMQODA==
X-Received: by 2002:a1c:5403:: with SMTP id i3mr4520743wmb.10.1588767170169;
        Wed, 06 May 2020 05:12:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11d7:2f21:f38b:17e? ([2001:b07:6468:f312:11d7:2f21:f38b:17e])
        by smtp.gmail.com with ESMTPSA id k23sm2529672wmi.46.2020.05.06.05.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 05:12:49 -0700 (PDT)
Subject: Re: [GIT PULL 0/1] KVM: s390: Fix for running nested under z/VM
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
References: <20200506115945.13132-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <918fcace-dac6-bc33-6713-19703fc96180@redhat.com>
Date:   Wed, 6 May 2020 14:12:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200506115945.13132-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06/05/20 13:59, Christian Borntraeger wrote:
> Paolo,
> a fix for kvm/master.
> 
> The following changes since commit 2a173ec993baa6a97e7b0fb89240200a88d90746:
> 
>   MAINTAINERS: add a reviewer for KVM/s390 (2020-04-20 11:24:00 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.7-3
> 
> for you to fetch changes up to 5615e74f48dcc982655543e979b6c3f3f877e6f6:
> 
>   KVM: s390: Remove false WARN_ON_ONCE for the PQAP instruction (2020-05-05 11:15:05 +0200)
> 
> ----------------------------------------------------------------
> KVM: s390: Fix for running nested uner z/VM
> 
> There are circumstances when running nested under z/VM that would trigger a
> WARN_ON_ONCE. Remove the WARN_ON_ONCE. Long term we certainly want to make this
> code more robust and flexible, but just returning instead of WARNING makes
> guest bootable again.
> 
> ----------------------------------------------------------------
> Christian Borntraeger (1):
>       KVM: s390: Remove false WARN_ON_ONCE for the PQAP instruction
> 
>  arch/s390/kvm/priv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Pulled, thanks.

Paolo

