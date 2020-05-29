Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E11E79C1
	for <lists+linux-s390@lfdr.de>; Fri, 29 May 2020 11:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgE2Js0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 29 May 2020 05:48:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22350 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726803AbgE2JsU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 29 May 2020 05:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590745699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f6w/D95eveaUv1V0PC/H4Q2Slese/OFGRios5LqI3Lo=;
        b=Xp+FpzNSig6u6XpQeRDVCu08pG9SZU1pkJBd1viCvCmkXu0jmPnJcVNPkybA+vaeoeRWjH
        Ky3xEa33kvBO+9ZCGKIGTreFRWvirjEuBUhsGa3ddFMS2aTX7oDMAq1qZh23zjgEKQ+gSn
        lDsN6OevHGTbIs7EhPRSnkIMk7yQ1Mo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-ffkgPdgANBukRDQWlb7LDA-1; Fri, 29 May 2020 05:48:17 -0400
X-MC-Unique: ffkgPdgANBukRDQWlb7LDA-1
Received: by mail-wr1-f71.google.com with SMTP id 3so822222wrs.10
        for <linux-s390@vger.kernel.org>; Fri, 29 May 2020 02:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f6w/D95eveaUv1V0PC/H4Q2Slese/OFGRios5LqI3Lo=;
        b=iCRNAICTHAE953T7sU/XFO9xsGX/mx4KBe1HLecFV6hqVtnwEDdU8tYUBZVgjCAMPZ
         Rj81syv+0ZE9Xd4A/cPkuBwix3qjwPj23oqLx5bjBvpkMG1ywqbg+xCKKpteBfTBbOoV
         17DHl9AS95JO/EN3jaZ2N0VBP12oojSWCPTptgM2n3D7QcBsvv3KpKB9SaSSjoVllDvH
         LdS1fMNFvps5SxX7v+OytFcoaSUYq7NeGvLU0Jm/yctcWdclFJTzOfajboVzSB1RrlM8
         MX6+amKtoBa4qgPaxl/gYhYokUncOyyuJzb2+fwv3L4PJiWO4uIuDPLboClU5Qt6IG29
         CgVw==
X-Gm-Message-State: AOAM53167Sx+HdbCNAJStgIW0yxu+2BPM+1N00D7dT5rImu2NhEED5iI
        wrHjOpbphhrHElhpeoym2XVC0HeflynMRWHJP+h0BDIcsmE7NLx3Yg2A6/sJHXJFYNgQKRE2VQD
        +W+2VsS28BobwK4thk8P/aA==
X-Received: by 2002:a05:6000:124e:: with SMTP id j14mr7990027wrx.154.1590745695769;
        Fri, 29 May 2020 02:48:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwY5u800IehczM/cQdM/5qPUlY08WZ5sRKP7f3fL0jBY9tgOmWNoklBLDcXU/RONPfyNhc2eg==
X-Received: by 2002:a05:6000:124e:: with SMTP id j14mr7990004wrx.154.1590745695574;
        Fri, 29 May 2020 02:48:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b096:1b7:7695:e4f7? ([2001:b07:6468:f312:b096:1b7:7695:e4f7])
        by smtp.gmail.com with ESMTPSA id k26sm10567358wmi.27.2020.05.29.02.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 02:48:15 -0700 (PDT)
Subject: Re: [PATCH v4 6/7] KVM: MIPS: clean up redundant 'kvm_run' parameters
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Huacai Chen <chenhuacai@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>, paulus@ozlabs.org,
        mpe@ellerman.id.au,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org, hpa@zytor.com,
        Marc Zyngier <maz@kernel.org>, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        christoffer.dall@arm.com, Peter Xu <peterx@redhat.com>,
        thuth@redhat.com, kvm@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
 <20200427043514.16144-7-tianjia.zhang@linux.alibaba.com>
 <CAAhV-H7kpKUfQoWid6GSNL5+4hTTroGyL83EaW6yZwS2+Ti9kA@mail.gmail.com>
 <37246a25-c4dc-7757-3f5c-d46870a4f186@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30c2ac06-1a7e-2f85-fbe1-e9dc25bf2ae2@redhat.com>
Date:   Fri, 29 May 2020 11:48:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <37246a25-c4dc-7757-3f5c-d46870a4f186@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 27/05/20 08:24, Tianjia Zhang wrote:
>>>
>>>
> 
> Hi Huacai,
> 
> These two patches(6/7 and 7/7) should be merged into the tree of the
> mips architecture separately. At present, there seems to be no good way
> to merge the whole architecture patchs.
> 
> For this series of patches, some architectures have been merged, some
> need to update the patch.

Hi Tianjia, I will take care of this during the merge window.

Thanks,

Paolo

