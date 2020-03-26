Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252F4193C6A
	for <lists+linux-s390@lfdr.de>; Thu, 26 Mar 2020 10:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgCZJ6w (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 26 Mar 2020 05:58:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57797 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727699AbgCZJ6w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Mar 2020 05:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585216730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mu5k/muTMFikZ1Us7/EnXaPhY0MlU2ypQjlH90iIurc=;
        b=Zs/upUzqPKCW7e6JWh5TjBtC5F9lRe0rW708sYOuwbdqmw3+FFwhEAKK4sATl54wo6BmdN
        ji/oOG1UoCkbWxKC6FjyWuiwpeaqevhnA9z7Km4qPlmimsA+sXTGeyrq6Bjx26I+OySVXg
        /ScUt0HeQ/chL6mC/wDmo73elpKdQLg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-VZehuTV4OXqb5XVGDRICGw-1; Thu, 26 Mar 2020 05:58:49 -0400
X-MC-Unique: VZehuTV4OXqb5XVGDRICGw-1
Received: by mail-wr1-f69.google.com with SMTP id o18so2780302wrx.9
        for <linux-s390@vger.kernel.org>; Thu, 26 Mar 2020 02:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mu5k/muTMFikZ1Us7/EnXaPhY0MlU2ypQjlH90iIurc=;
        b=ZCDN0mOcf6HMwWsx/GKuVRMfJ4rrpb9wJHla0IN9/yIPwFcx2T5EErk9LxGjVrO+Pi
         jxs05Zr4Sx3I4sdd5GB6D+qSzkgSFDTLLdTRhplSBfcqiZ9Pf73etq91M41SjIt5eU6d
         /L1KFcoMGdmoVpISPhxtSKTdwshVVYXyNupdth7zzB5YQrhpvsIxjXGvJj6Oh9EyxTmX
         4hlNEqjL6aNFnI0GNa8aTud0tEFcf8Gxgijh3wE5013wtGsxwrm0DYRhO7ZL1TU6VxwT
         R7WJ0buAol9BpjnSwiO0K0+tcpsW7kkXDVy8W6VCSdmTcVuXKxHPL5J2+1i2Mxe7+Ybh
         hTDg==
X-Gm-Message-State: ANhLgQ2FAfmxeipyaz9CNVc3vVBv78MVZBzMiyK+k1SrcwPyOARUhdyh
        eC4YkcUCcuh4DXZcz43JK+3g0PqgMjOfh4qvblqQp/NlUiR/n8tKnWJpAwGKfha733jCJkg5s0z
        AXAqon/aMXbk54DhFiPi2UA==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr8476848wro.415.1585216727618;
        Thu, 26 Mar 2020 02:58:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtUuqzsVOQscsCsoJwZd9JlTbWvDJQ9qZyiEHXOIIM9um2wuL1QZxJ2xekHIC4yr7TeXRS0lw==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr8476820wro.415.1585216727315;
        Thu, 26 Mar 2020 02:58:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e4f4:3c00:2b79:d6dc? ([2001:b07:6468:f312:e4f4:3c00:2b79:d6dc])
        by smtp.gmail.com with ESMTPSA id k126sm2891486wme.4.2020.03.26.02.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 02:58:46 -0700 (PDT)
Subject: Re: [GIT PULL 0/2] KVM: s390: changes for 5.7 part 2
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <20200324125030.323689-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6977ffb-e4e5-1f3d-3db2-55742bacaa1d@redhat.com>
Date:   Thu, 26 Mar 2020 10:58:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324125030.323689-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 24/03/20 13:50, Christian Borntraeger wrote:
> Paolo,
> 
> two more patches for 5.7.
> 
> The following changes since commit cc674ef252f4750bdcea1560ff491081bb960954:
> 
>   KVM: s390: introduce module parameter kvm.use_gisa (2020-02-27 19:47:13 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.7-2
> 
> for you to fetch changes up to f3dd18d444c757840920434e62809b6104081b06:
> 
>   KVM: s390: mark sie block as 512 byte aligned (2020-03-23 18:30:33 +0100)
> 
> ----------------------------------------------------------------
> KVM: s390: cleanups for 5.7
> 
> - mark sie control block as 512 byte aligned
> - use fallthrough;
> 
> ----------------------------------------------------------------
> Christian Borntraeger (1):
>       KVM: s390: mark sie block as 512 byte aligned
> 
> Joe Perches (1):
>       KVM: s390: Use fallthrough;
> 
>  arch/s390/include/asm/kvm_host.h |  2 +-
>  arch/s390/kvm/gaccess.c          | 23 +++++++++++++----------
>  arch/s390/kvm/interrupt.c        |  2 +-
>  arch/s390/kvm/kvm-s390.c         |  4 ++--
>  arch/s390/mm/gmap.c              |  6 +++---
>  5 files changed, 20 insertions(+), 17 deletions(-)
> 

Pulled, thanks.

Paolo

