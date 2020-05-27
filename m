Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3ED1E4978
	for <lists+linux-s390@lfdr.de>; Wed, 27 May 2020 18:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390326AbgE0QLV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 27 May 2020 12:11:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52755 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389442AbgE0QLU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 May 2020 12:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590595879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eT5Xu5kIXMyMszPnZ6Nrn2fPPIp8gis023GPtPf71Sk=;
        b=dGArioqRlPQcHZQ6B+Et5A6eTtuPXnUXIrpDreC9OKy09KKD3iOqiO+nH5cI0bNxCV+1dp
        hrb1IffOAkzBx1IViwfbWOiJ9oKVvZy9EuttHxPwXT7vmx9J/cNQvs2u9PllvygWVxtd9f
        lP0C63dRkVjRz/LmDInyKno8vbAMq20=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-agEhLQ46OomLykjB_tVUdQ-1; Wed, 27 May 2020 12:11:18 -0400
X-MC-Unique: agEhLQ46OomLykjB_tVUdQ-1
Received: by mail-wm1-f69.google.com with SMTP id x11so977788wmc.9
        for <linux-s390@vger.kernel.org>; Wed, 27 May 2020 09:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eT5Xu5kIXMyMszPnZ6Nrn2fPPIp8gis023GPtPf71Sk=;
        b=S/s0q4H6CcbztFnT4a8gYIKLeLTtnshwStNXKIpKGXouvnnaMTHu71SWE//33CseT0
         5tUH7lFn6mb2+SisrJJm6EB08PEqQl+YHTmcMuAMH12LMHvhTjWfKa1fR0FOpaG6iMDm
         WOtVCLQC+v2kQrb7VV3ccUS0RWkIUJz1tGxRVQ3/l+amFRVJBlqu2lEqQlm4hGGYW8y0
         7j8kxOVLX78Q4rfEpGK/N6cVhVkxJck7qQJtE+9Q4j+8vaqcoW1lxNox0Z5PzNgZKNg7
         hLzT4rAkUGmeEyTeAB5oo2CA0CEV393AgZpbwjEJN3kXpytU5rOd1yuy3Vs07ygrFEbq
         0drg==
X-Gm-Message-State: AOAM5322jFYvYxWhkPss0so/c5aTdSEyqKjRuiCoOu9IxD2b8kSF+6Ua
        eEhXnSEa47HXfHfUc9mPbjs9L+HR34q8TOsheP0aK4alVIIq9bO6RFWag7+L25m832fBgrV+7cF
        sjBp4nX1BotQr/ge1nDLMyw==
X-Received: by 2002:a1c:4b02:: with SMTP id y2mr4723158wma.115.1590595876813;
        Wed, 27 May 2020 09:11:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL+M9svBpeGz1dmd2j1jjOm8lh//w8Ik9J0JQbYuBhPd7M71zBmJt18P2Dj2Pv/PipkmzSOQ==
X-Received: by 2002:a1c:4b02:: with SMTP id y2mr4723135wma.115.1590595876589;
        Wed, 27 May 2020 09:11:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id t185sm3187454wmt.28.2020.05.27.09.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 09:11:16 -0700 (PDT)
Subject: Re: [GIT PULL 0/3] KVM: s390: Cleanups for 5.8
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20200526093313.77976-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <42e54cbc-799a-9275-5084-04410b1eac33@redhat.com>
Date:   Wed, 27 May 2020 18:11:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200526093313.77976-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 26/05/20 11:33, Christian Borntraeger wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.8-1

Pulled, thanks.

Paolo

