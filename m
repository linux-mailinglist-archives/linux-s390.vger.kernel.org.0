Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9851470DEE4
	for <lists+linux-s390@lfdr.de>; Tue, 23 May 2023 16:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbjEWONf (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 23 May 2023 10:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237163AbjEWON3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 May 2023 10:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7556E10CB
        for <linux-s390@vger.kernel.org>; Tue, 23 May 2023 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684851149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6ymbsRhedi62yE5ybjLWHl7Je8Q34mz7d4hOSaDDBI=;
        b=gYDKbDUGu9TBvi1VKLeGoJzAKqn9oF9fNkrhebzr8Z3RVdp8hprc/DI+4C7RSZuFmRwJm+
        LXEf/ytEmdcVBPUth/Wx0vY5vNIfb2Th+xBaMgIxfssSJ4bXeUpTYg9CSmpX3m/cNBZVns
        PFVBCO+sld1mj7mumfOapTF8Z5n+b1k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-SCAuIEp3OYmkyrUrsFsPVw-1; Tue, 23 May 2023 10:12:26 -0400
X-MC-Unique: SCAuIEp3OYmkyrUrsFsPVw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f60481749eso12656915e9.1
        for <linux-s390@vger.kernel.org>; Tue, 23 May 2023 07:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684851145; x=1687443145;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6ymbsRhedi62yE5ybjLWHl7Je8Q34mz7d4hOSaDDBI=;
        b=dz3s6aqgRc+kgENh+BIumSdLze8AEBU9SdyKGhNPbg25kmyc/W7hDAhAHPHtL137LI
         Clvz4jTm1pddQOpeshNwnELCBlhjdmC2FbMLA8zjCH9LilHq/wrVKmJSH7D3p8cSNlbM
         s2aSXq/OIBhjcidDz5Xi63MT65MeV9pptbpig1ORZjHV2bN6eSXqBn7ksLLBdtTttAPM
         janfvL+HmN48Pc7pB0NwMdpsL6s/39h2+3jaGSZ+NSiCagj3dw/CoOQx3YlunJRni6YJ
         Jt10glfDuWLjJtktUtfqWdqogIcBoduoZAmtTqVCNkrjRV0IkriZeWa5f18K5+D5ixpG
         KXQQ==
X-Gm-Message-State: AC+VfDwz/2JOQdM6ppIJgMDBFApuBSBwaHUDLEMriMfhTMumvXPxMuI0
        0pMv48GQQ9k3p7YvizMs/2PbvjV9cp2CvY8tMYCtIpcRndv6SWAeSa6VzAfCx9yUz5lLSkmE7ZM
        C1/C9j9C4b4uBM5CYrhawJX48Xk4g7A==
X-Received: by 2002:a05:600c:5114:b0:3f1:80d0:906b with SMTP id o20-20020a05600c511400b003f180d0906bmr10660220wms.4.1684851145113;
        Tue, 23 May 2023 07:12:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4PRyFsUYjQDgdMQ0rwcHbQNxUTO5+6IeDakvZmyqviT+Wu6Oi9fOGHKM1Uo0kcEIQu0ienSA==
X-Received: by 2002:a05:600c:5114:b0:3f1:80d0:906b with SMTP id o20-20020a05600c511400b003f180d0906bmr10660204wms.4.1684851144639;
        Tue, 23 May 2023 07:12:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd? (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de. [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
        by smtp.gmail.com with ESMTPSA id f4-20020a1c6a04000000b003f1978bbcd6sm3052337wmc.3.2023.05.23.07.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 07:12:24 -0700 (PDT)
Message-ID: <b4b2d652-801f-7d2d-9277-8fd8a69d7307@redhat.com>
Date:   Tue, 23 May 2023 16:12:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] KVM: s390/diag: fix racy access of physical cpu number in
 diag 9c handler
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Janosch Frank <frankja@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20230523140500.271990-1-borntraeger@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230523140500.271990-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 23.05.23 16:05, Christian Borntraeger wrote:
> We do check for target CPU == -1, but this might change at the time we
> are going to use it. Hold the physical target CPU in a local variable to
> avoid out-of-bound accesses to the cpu arrays.
> 
> Cc: Pierre Morel <pmorel@linux.ibm.com>
> Fixes: 87e28a15c42c ("KVM: s390: diag9c (directed yield) forwarding")
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>   arch/s390/kvm/diag.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index 807fa9da1e72..3c65b8258ae6 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -166,6 +166,7 @@ static int diag9c_forwarding_overrun(void)
>   static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
>   {
>   	struct kvm_vcpu *tcpu;
> +	int tcpu_cpu;
>   	int tid;
>   
>   	tid = vcpu->run->s.regs.gprs[(vcpu->arch.sie_block->ipa & 0xf0) >> 4];
> @@ -181,14 +182,15 @@ static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
>   		goto no_yield;
>   
>   	/* target guest VCPU already running */
> -	if (READ_ONCE(tcpu->cpu) >= 0) {
> +	tcpu_cpu = READ_ONCE(tcpu->cpu);
> +	if (tcpu_cpu >= 0) {
>   		if (!diag9c_forwarding_hz || diag9c_forwarding_overrun())
>   			goto no_yield;
>   
>   		/* target host CPU already running */
> -		if (!vcpu_is_preempted(tcpu->cpu))
> +		if (!vcpu_is_preempted(tcpu_cpu))
>   			goto no_yield;
> -		smp_yield_cpu(tcpu->cpu);
> +		smp_yield_cpu(tcpu_cpu);
>   		VCPU_EVENT(vcpu, 5,
>   			   "diag time slice end directed to %d: yield forwarded",
>   			   tid);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

