Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094DB67CAAC
	for <lists+linux-s390@lfdr.de>; Thu, 26 Jan 2023 13:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbjAZMOI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 26 Jan 2023 07:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjAZMOH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 26 Jan 2023 07:14:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55BE62792
        for <linux-s390@vger.kernel.org>; Thu, 26 Jan 2023 04:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674735198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=df9zb9ds5IPmNup55FO6H71Nj0ejludr4WqF0rB5QrM=;
        b=Hf9IdqP25bwiqLG/A/NJ5ogs5EH2hz2sAuIQEI1kfCwyG3jPVT5dub7qudN8LOBdiPCf31
        mZm7K0M0y3K8fxLWMi+i2NqDW0vm7eOVWXGdiMjogm7DjHjlps3WMrLZ+5CFGcAxC6HcfG
        6CDATco2MZ+m1Ie7E0lBai+BU3KHVMI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-502-x--k9SK6OR2TDJ9l7nCBNQ-1; Thu, 26 Jan 2023 07:13:17 -0500
X-MC-Unique: x--k9SK6OR2TDJ9l7nCBNQ-1
Received: by mail-qk1-f200.google.com with SMTP id de37-20020a05620a372500b00707391077b4so905036qkb.17
        for <linux-s390@vger.kernel.org>; Thu, 26 Jan 2023 04:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=df9zb9ds5IPmNup55FO6H71Nj0ejludr4WqF0rB5QrM=;
        b=dRgMLaJyJeANQPY256NS6JO1Xc7qTWLdKZACZZ5R/63nJVYJXvGS1kQEcHOJBivpup
         BfBDs4RegfUGix+YUL8T589L/SsXERNPl0jEW0jCtWqjLkNPb+NWStAB3fbHrjK6IQQ3
         x6R9QS/f889Xsq9oYNQoAEMd12xGmFZJf6iSz9KEArCVgQdrO/irC7JCWvYOOvMPBoLA
         mz3JjKDRR+WBRDoPulh4mnlRFZibQwEy9joYpDy4NNROrElknrOHgSZtlPv6pX2LlDm1
         TRCh3tDqWi38xgj0spf2+7ycsQOWBVsPP0vSnQdAwwtmhcLrM+HZrrRvIa1rSp6VL8Ic
         chFg==
X-Gm-Message-State: AO0yUKVmJxfNV9SL9bBgaaBbCsycR8rkSsBbMM6ysRB27KKFk7XxeFXv
        /iX3M9BAnMc/XZmzUkr4iKqTdS8FKdpV5FHYgfu4R5x+rS4mH/2Y3rZQDm3qXvaCLeGK38g+czo
        0b5clPaTRHId2QTrzmAhX3w==
X-Received: by 2002:a05:622a:1114:b0:3b7:ed2c:fbb7 with SMTP id e20-20020a05622a111400b003b7ed2cfbb7mr2996176qty.0.1674735197165;
        Thu, 26 Jan 2023 04:13:17 -0800 (PST)
X-Google-Smtp-Source: AK7set+3bupg7QW2LEoYM6DfA2/q552ZZlO5ojHc9xon3id8NQsaud7k8MHTZIh/HseFB8NDInu28w==
X-Received: by 2002:a05:622a:1114:b0:3b7:ed2c:fbb7 with SMTP id e20-20020a05622a111400b003b7ed2cfbb7mr2996147qty.0.1674735196947;
        Thu, 26 Jan 2023 04:13:16 -0800 (PST)
Received: from [192.168.0.2] (ip-109-43-177-174.web.vodafone.de. [109.43.177.174])
        by smtp.gmail.com with ESMTPSA id 2-20020ac82082000000b003ad373d04b6sm611659qtd.59.2023.01.26.04.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 04:13:15 -0800 (PST)
Message-ID: <11397ebe-f751-06de-1275-72f7303d4e35@redhat.com>
Date:   Thu, 26 Jan 2023 13:13:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 09/14] KVM: s390: Dispatch to implementing function at
 top level of vm mem_op
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
 <20230125212608.1860251-10-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230125212608.1860251-10-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 25/01/2023 22.26, Janis Schoetterl-Glausch wrote:
> Instead of having one function covering all mem_op operations,
> have a function implementing absolute access and dispatch to that
> function in its caller, based on the operation code.
> This way additional future operations can be implemented by adding an
> implementing function without changing existing operations.
> 
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   arch/s390/kvm/kvm-s390.c | 38 ++++++++++++++++++++++++--------------
>   1 file changed, 24 insertions(+), 14 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

