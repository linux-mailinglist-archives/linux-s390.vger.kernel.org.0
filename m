Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E164C011B
	for <lists+linux-s390@lfdr.de>; Tue, 22 Feb 2022 19:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiBVSSu (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 22 Feb 2022 13:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiBVSSu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Feb 2022 13:18:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE55591AD7
        for <linux-s390@vger.kernel.org>; Tue, 22 Feb 2022 10:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645553901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2PmKrKI3EWZmz7GdObnPojUMJef667KazfUaDx+B+HE=;
        b=cumtYu7/9XObZZJq8zTjEXQSUm4jIGPWNgYbvVQA2K2JutSNFfOHF4tFEL1LaDMVv2vp9E
        0pPqCORu1U8RFTKxaj91NLYwDLpVDQA9OwBIRnOlVBOJmL5VCJkm79rnsvD2kdJKkst6K9
        tc6kmbTiCSsk6urQeHJm2G4rFxTrI8U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-_JyiGk2HPvma9np9hCKuug-1; Tue, 22 Feb 2022 13:18:20 -0500
X-MC-Unique: _JyiGk2HPvma9np9hCKuug-1
Received: by mail-ed1-f70.google.com with SMTP id g5-20020a056402090500b0040f28e1da47so12450573edz.8
        for <linux-s390@vger.kernel.org>; Tue, 22 Feb 2022 10:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2PmKrKI3EWZmz7GdObnPojUMJef667KazfUaDx+B+HE=;
        b=Cl6uNEcCI8P032IHLs8wQRIG+flO5iPRuEMPI5rtyjb4J3XF3IkR4ppbXkjeyUi4S3
         xwXktbALzLo99uWxdZK938d5DuzaJe6qxp24a8UKC/J7ohxumWl24g+SF9OZul5frO5M
         dcZkhDrjh+oWAMY8wEXQhH6VuGmoeIsdUTMEWy/Mc4cqiNFcxMXx0nsowHdz4T4Y/MGe
         jA/JJCp+UDNBEqZLPwSbxIkNF1/vnRLeeXu8Jc+VIrcifez26vsvJjVtvwmT6XKY9FNT
         chlFff0Eat9UBYd0K/flToW6s5ajZfkDL5DpHWHVbJ5y0xTGreRubvD9z1CbsVmBL0wr
         xj/w==
X-Gm-Message-State: AOAM5328KzE8yrIxtYSOyn4FyN/LKdgrdrWrtUvL5LdbvCoG4ocNU5zX
        ZpSAg2gWCWQW6Zgk6/kv5YC5E/OfcVUCOVU5GATes29ruXyzZ60cYgtF8fi7xLD/EMwwZm2lZZC
        H8S0LRaLHEJDP9KzYiRKGbw==
X-Received: by 2002:a17:906:8a86:b0:6ae:9c35:35c7 with SMTP id mu6-20020a1709068a8600b006ae9c3535c7mr20962706ejc.494.1645553899422;
        Tue, 22 Feb 2022 10:18:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCwlo4F988pYzuSYl9uB+mnzlLrkaQM96Qe8NKdt8vVTBhD0xY2FSj6fRNGqyRK6exjOLlxA==
X-Received: by 2002:a17:906:8a86:b0:6ae:9c35:35c7 with SMTP id mu6-20020a1709068a8600b006ae9c3535c7mr20962694ejc.494.1645553899163;
        Tue, 22 Feb 2022 10:18:19 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id h19sm10718682edt.6.2022.02.22.10.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 10:18:18 -0800 (PST)
Message-ID: <d6c6803c-518f-8ab3-a2a5-b73f600ebafb@redhat.com>
Date:   Tue, 22 Feb 2022 19:18:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [GIT PULL 00/13] KVM: s390: Changes for 5.18 part1
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
References: <20220222094910.18331-1-borntraeger@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220222094910.18331-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2/22/22 10:48, Christian Borntraeger wrote:
> Paolo,
> 
> first part of the s390 parts of KVM for 5.18. This is on top of the fix
> that went into Linus tree, so it will move kvm/next to something between
> rc3 and rc4.
> 
> I added 2 later fixups for the storage key patches on top. Let me know if
> you prefer them folded in.
> 
> We might do a 2nd pull request later on depending on timing, review and
> other constraints
> with
> - rewritten selftest for memop
> - ultravisor device (could also go via s390 tree)
> - parts/all of Claudios lazy destroy
> - parts/all of PCI passthru (could be later and might go via s390 tree as
>    well via a topic branch)
> - followup to guest entry/exit work if we find a small solution
> - adapter interruption virtualization facility for secure guests
> 
> The following changes since commit 09a93c1df3eafa43bcdfd7bf837c574911f12f55:
> 
>    Merge tag 'kvm-s390-kernel-access' from emailed bundle (2022-02-09 09:14:22 -0800)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.18-1
> 
> for you to fetch changes up to 3d9042f8b923810c169ece02d91c70ec498eff0b:
> 
>    KVM: s390: Add missing vm MEM_OP size check (2022-02-22 09:16:18 +0100)

Pulled, thanks.

Paolo

