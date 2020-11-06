Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34852A96F6
	for <lists+linux-s390@lfdr.de>; Fri,  6 Nov 2020 14:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbgKFNZJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 6 Nov 2020 08:25:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50535 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727287AbgKFNZJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Nov 2020 08:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604669108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qkuxbR4G3FNGPeIH1SPkdjbNDS2i/SsFPcilaKLEB9Q=;
        b=fS9FwvJD9hPJcH7/VsRXj7W7/lzDmPVBqjzU3u8ackgmSyEdaM03Rjyicwf8Y3IXzZXLej
        HIBoRHCLNgLBBog4FCNfsPjSusVb30dFs8UmPmWYGgbMWb4v0EVfd9R/40IjcrKQ8TLu6t
        3Cb0ELlMPF1iusOJnSxva16P6ixnrWI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-atWYDAHwP6eJDlbJg45w4w-1; Fri, 06 Nov 2020 08:25:06 -0500
X-MC-Unique: atWYDAHwP6eJDlbJg45w4w-1
Received: by mail-wr1-f71.google.com with SMTP id h11so459129wrq.20
        for <linux-s390@vger.kernel.org>; Fri, 06 Nov 2020 05:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qkuxbR4G3FNGPeIH1SPkdjbNDS2i/SsFPcilaKLEB9Q=;
        b=Exmq5Gd4RNaDg4dlvG4Cibeehox1AvJPRHibqoYW3YnQmhpEjnZeqk149PQlI/+vGb
         jy/1AQiU5M9RqRB15z1hmJs7fA/Vrli/tFfv1lJ9ZZ0mKko6q2T9/ajVFA0bj0WU0/6u
         cNvFDWpukCF2hQhZKeSLq9jv1igf7VX0X6gcdQNF/d/gebajGXHgjjU1qpBW6OZiUBT2
         n6668RZrAhJtmVhVAYSNjp72puvF8BL+l3075BIicFYwU2QJISYppxPEZzOjVXZC42u7
         wE46Jsk1bdyAjSzFlU84rOouqyYTuGJWmPRy3N/GuJ8bSwEQVIBVuT+tmUEV/PP3Q2vC
         /0cQ==
X-Gm-Message-State: AOAM532o+pzb1ik/L0DVJrEfqZflJad5WAX1SvluBu4wwU/dnwR3VVpF
        NhqMqrecP92QP752EX2+wLCqsUs6etjiX3nP9SGz3jLBpTtB1Fmn46No+7bIGWu+dlR9ER873IN
        N9+t/I5wLCzEjJftjNaxE9g==
X-Received: by 2002:a7b:c772:: with SMTP id x18mr2613305wmk.185.1604669102568;
        Fri, 06 Nov 2020 05:25:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZ/2LRBRmoiShw0UuRFze9ZSUcWJNrDk2w76ayt2tZ+sF8mfL6vVrdwS624jyuuwMWXfuf+A==
X-Received: by 2002:a7b:c772:: with SMTP id x18mr2613286wmk.185.1604669102362;
        Fri, 06 Nov 2020 05:25:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:48f9:bea:a04c:3dfe? ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
        by smtp.gmail.com with ESMTPSA id z6sm2385713wmi.1.2020.11.06.05.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 05:25:01 -0800 (PST)
Subject: Re: [kvm-unit-tests PATCH v2 1/4] memory: allocation in low memory
To:     Janosch Frank <frankja@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com,
        thuth@redhat.com, imbrenda@linux.ibm.com
References: <1601303017-8176-1-git-send-email-pmorel@linux.ibm.com>
 <1601303017-8176-2-git-send-email-pmorel@linux.ibm.com>
 <20200928173147.750e7358.cohuck@redhat.com>
 <136e1860-ddbc-edc0-7e67-fdbd8112a01e@linux.ibm.com>
 <f2ff3ddd-c70e-b2cc-b58f-bbcb1e4684d6@linux.ibm.com>
 <63ac15b1-b4fe-b1b5-700f-ae403ce7fb85@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fc553f1a-8ddd-59b0-9dec-8bdddfb5483d@redhat.com>
Date:   Fri, 6 Nov 2020 14:25:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <63ac15b1-b4fe-b1b5-700f-ae403ce7fb85@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/11/20 15:15, Janosch Frank wrote:
>> Isn't it possible to go on with this patch series.
>> It can be adapted later to the changes that will be introduced by
>> Claudio when it is final.
>>
>>
> Pierre, that's outside of my jurisdiction, you're adding code to the
> common code library.
> 
> I've set Paolo CC, let's see if he finds this thread:)
> 

I have queued Claudio's series already, so let's start from there.

Paolo

