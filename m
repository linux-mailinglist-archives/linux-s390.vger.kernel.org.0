Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CF74FDF8B
	for <lists+linux-s390@lfdr.de>; Tue, 12 Apr 2022 14:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353908AbiDLMVL (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 12 Apr 2022 08:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355399AbiDLMTG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Apr 2022 08:19:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91C858CCED
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 04:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649762486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OmkF7jhcAzb+P4y7LnCV0pUjKAAJuFKPCLofiKL8Evs=;
        b=RNGpvwfOx9QF1nnqCLzyhCIAisMReyGxBNBKvJ1q/coWR0Lmmg5mNVY8YmXCtcQvy+b3TU
        FZyMOH78PpXNa2ZQ+FFgLGdaJLGwFDgLrTfVlfw9lHrRaUpR7RZ4hpT450En/DGck9HYKA
        w4SzYI51ZWv8XeGXvPzWdY+vmJE1Xn4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-0FzmMx-LMhWrLqhTW8198A-1; Tue, 12 Apr 2022 07:21:25 -0400
X-MC-Unique: 0FzmMx-LMhWrLqhTW8198A-1
Received: by mail-wm1-f69.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso1152040wmh.2
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 04:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OmkF7jhcAzb+P4y7LnCV0pUjKAAJuFKPCLofiKL8Evs=;
        b=FIvH+a7Z0gB/XwwpIZaPSubxNZaR+2xaQ7LmpRbKVndt9Midq0xSylTn3iVauwFncC
         eMS1ZPgchvi7mhcgsu1oRlJ9+c8+j7vVrQ/h2Z0pyRcw4bdB5TzvXUxjwrEY6TPTkzI1
         rNI15Gavjay/VZgY1NBD1chmivLmOyODtqULzJAvtG6Kxl4BWI33WQS3fnNwxJ0WlWx5
         vtAl/wYy1jiLseujTW38O9nunYJ6WC7ysp5eDibQyHuXCLAqWIJ48SqII/kctzjElrnV
         2TWOVbw34MAORSUKSZecI3fr2p5Fz/nqQVS7A9U0uMLf7lJY9jt3AX64LANrjht3IKdD
         o2kQ==
X-Gm-Message-State: AOAM530DaKH1lMBmNA5jcMMfjCDgeGgpUzfessLmgC0lhv1T/u4Ny5ju
        DY25+Ck40K7z8svX7VsgAG8hVDHWCbb1dWyjibxQ63WD04Xxv1iSM62Ovnk6kRX5606oPAEZpnE
        RSG1IGQa8GS0lLY79T5+f7Q==
X-Received: by 2002:a5d:68ca:0:b0:207:a1d3:da87 with SMTP id p10-20020a5d68ca000000b00207a1d3da87mr11487776wrw.492.1649762484357;
        Tue, 12 Apr 2022 04:21:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/Kw0q3fgkWeR+wmrlSRYZhQw4rSlTl9DYnNPKEvfsMOkzehUTCkk1OxeJc9yn+2f+8ODunA==
X-Received: by 2002:a5d:68ca:0:b0:207:a1d3:da87 with SMTP id p10-20020a5d68ca000000b00207a1d3da87mr11487763wrw.492.1649762484163;
        Tue, 12 Apr 2022 04:21:24 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm31164364wri.48.2022.04.12.04.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 04:21:23 -0700 (PDT)
Message-ID: <92ec4e4b-ea61-e1d5-b01d-843ea69d5071@redhat.com>
Date:   Tue, 12 Apr 2022 13:21:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [kvm-unit-tests PATCH 1/2] s390x: gs: move to new header file
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@redhat.com,
        farman@linux.ibm.com
References: <20220401123321.1714489-1-nrb@linux.ibm.com>
 <20220401123321.1714489-2-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220401123321.1714489-2-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 01/04/2022 14.33, Nico Boehr wrote:
> Move the guarded-storage related structs and instructions to a new
> header file because we will also need them for the SIGP store additional
> status tests.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   lib/s390x/gs.h | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   s390x/gs.c     | 54 +--------------------------------------
>   2 files changed, 70 insertions(+), 53 deletions(-)
>   create mode 100644 lib/s390x/gs.h



Reviewed-by: Thomas Huth <thuth@redhat.com>

