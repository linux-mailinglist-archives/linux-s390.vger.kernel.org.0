Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F092C791650
	for <lists+linux-s390@lfdr.de>; Mon,  4 Sep 2023 13:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245657AbjIDLlc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 4 Sep 2023 07:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjIDLlc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Sep 2023 07:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC14818C
        for <linux-s390@vger.kernel.org>; Mon,  4 Sep 2023 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693827640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ph2kayhn3p0Zo2NLGIgOqhEppuBiLgioGlifdo+elw0=;
        b=OJt3skdP2t6S3mGiQWtDdl4MRXcfokRrZEcMedvpb3i9gkLKoUDCzjan9gsefuqFCX1/AM
        9kUaJFGmBSRC5vNaAOveqNmoY+bhusVNfiwGEmCGlRUMSSGRvLxXJSBXjkxo1n5p4aHaJB
        SD5+eI94jqpfdorV1+XZrXKKfs/F20o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-hWfGytIQOl-bANsYr9BQVA-1; Mon, 04 Sep 2023 07:40:39 -0400
X-MC-Unique: hWfGytIQOl-bANsYr9BQVA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bcb0f9fe3bso15257061fa.2
        for <linux-s390@vger.kernel.org>; Mon, 04 Sep 2023 04:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693827638; x=1694432438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ph2kayhn3p0Zo2NLGIgOqhEppuBiLgioGlifdo+elw0=;
        b=HErutcqCD5JEQ6FzP0LRcYpkGExhFPGX+rkfRczFLjIjQl545ZB2IQcGnB48rYNOOO
         QMk8sjBT/rEoSJDk29JdeOibNVo0+g6yO3QgV6A+T0hJRj3Va5oE3QtNROFPuZ2JIFB9
         0vWLe506f/IUFss1VtJtcWooJcQ0QhgdiwPyGy1moY5gBXq6Eu+xmqpF72o/ClBqhYw9
         VrAmpMoIlunwdlAKVU/TPKuLKVB+ALi69bLIkXILCx/8cQda3cJKMgYAAXfWXl0O/Uum
         wVUaQsEzigeiQEExy9ZP5ozSQuIf+NYEDKiClKdO6A0mJh/+2o4JMUiVKE6vJ8MR5Cp4
         A4qA==
X-Gm-Message-State: AOJu0Yw6MFxnnbBtgNlXM4/LSEEeV/P5fDV08k6Q+H9MANu3vLH+L2MB
        5DU8o6uIK2ZbYqTKsuIyoh+b+k2fp5zxn84sYl8GZ039enyzAPh926PosD0wmRiWryuxGowPFNW
        2a5qslihb7LFpL0ayjpwDFw==
X-Received: by 2002:a05:651c:102a:b0:2bc:d582:e724 with SMTP id w10-20020a05651c102a00b002bcd582e724mr7160574ljm.31.1693827638123;
        Mon, 04 Sep 2023 04:40:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcZpUCzI/Sd4oNIPHkSQ6r8jBlzLt2AD3uqAea7UCJapx58GxUYsqxTWfZlTmX3/4RHmJM8g==
X-Received: by 2002:a05:651c:102a:b0:2bc:d582:e724 with SMTP id w10-20020a05651c102a00b002bcd582e724mr7160559ljm.31.1693827637731;
        Mon, 04 Sep 2023 04:40:37 -0700 (PDT)
Received: from [10.33.192.199] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id s17-20020a7bc391000000b003fe24441e23sm13885664wmj.24.2023.09.04.04.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 04:40:37 -0700 (PDT)
Message-ID: <5fdeb585-9bf6-93f6-1b74-348d6482f28f@redhat.com>
Date:   Mon, 4 Sep 2023 13:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [kvm-unit-tests PATCH v6 3/8] s390x: sie: switch to home space
 mode before entering SIE
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230904082318.1465055-1-nrb@linux.ibm.com>
 <20230904082318.1465055-4-nrb@linux.ibm.com>
 <e6b8a718-4c99-cd37-c73f-fcb604a67af4@redhat.com>
 <169382566786.97137.9911014409792025043@t14-nrb>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <169382566786.97137.9911014409792025043@t14-nrb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04/09/2023 13.07, Nico Boehr wrote:
> Quoting Thomas Huth (2023-09-04 11:59:30)
> [...]
>> If we want tests to be able in other modes in the future...
>>
>>> +      */
>>> +     old_cr13 = stctg(13);
>>> +     lctlg(13, stctg(1));
>>> +
>>> +     /* switch to home space so guest tables can be different from host */
>>> +     psw_mask_set_bits(PSW_MASK_HOME);
>>> +
>>> +     /* also handle all interruptions in home space while in SIE */
>>> +     irq_set_dat_mode(true, AS_HOME);
>>> +
>>>        while (vm->sblk->icptcode == 0) {
>>>                sie64a(vm->sblk, &vm->save_area);
>>>                sie_handle_validity(vm);
>>> @@ -66,6 +86,12 @@ void sie(struct vm *vm)
>>>        vm->save_area.guest.grs[14] = vm->sblk->gg14;
>>>        vm->save_area.guest.grs[15] = vm->sblk->gg15;
>>>    
>>> +     irq_set_dat_mode(true, AS_PRIM);
>>> +     psw_mask_clear_bits(PSW_MASK_HOME);
>>
>> ... we should maybe restore the previous mode here instead of switching
>> always to primary mode?
> 
> I don't want to add untested "should work" code, so I'd much prefer if we'd
> have a proper test which uses multiple address spaces - and that seems out
> of scope for this series to me.
> 
>> Anyway, could be done later, but you might want to update your comment.
> 
> Yep, agree, I'd prefer to do this later.
> 
> Pardon if I'm not getting it but the comment IMO makes sufficiently clear
> that multiple AS are for future extensions. If you have any suggestion on
> how this could be clearer, I'd be happy to incorporate.

I guess it's ok for now. I was thinking of something like:

+	 * - switching every time makes it easier to extend this in the future,
+	 *   for example to allow tests to run in whatever space they want
+	 *   (this still needs some modification to return to the previous mode below)

... but it's maybe too verbose already. So just keep your
patch the way it currently is.

  Thomas

