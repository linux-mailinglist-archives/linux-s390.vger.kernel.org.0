Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7641B2810
	for <lists+linux-s390@lfdr.de>; Tue, 21 Apr 2020 15:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgDUNgw (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 21 Apr 2020 09:36:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57715 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbgDUNgv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Apr 2020 09:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587476210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wCsZ3VGNPNsrXjnUXsD0UNS2OD+KJF3obERZuUYiksw=;
        b=aQLSkrfLlh06gmlGcYDCiH5r7jA0vGadKlTlC3SjpLnma3Ml4A8tGxJuqG3CoCTvxwh1FL
        Ir343USQI8686iJXZ2m/+Gd3KWya0xm4bxJtf7BFrV3wySZE8/Gl8dcnGlwki7Oo45bqkp
        ibWjoDgOd74Sc29/oEyI+YjVLREJSE4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-4Vo1RSvqP06ylF4QfzisIg-1; Tue, 21 Apr 2020 09:36:49 -0400
X-MC-Unique: 4Vo1RSvqP06ylF4QfzisIg-1
Received: by mail-wm1-f69.google.com with SMTP id f81so1389094wmf.2
        for <linux-s390@vger.kernel.org>; Tue, 21 Apr 2020 06:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wCsZ3VGNPNsrXjnUXsD0UNS2OD+KJF3obERZuUYiksw=;
        b=pE1yDFC1mSw7evA3Cm1dMiNDlTWv4It8vDAwMkZkMmA04dlJ/zZl01zkv4WsRxXUsw
         AHYqrFRlyV/98ohIWPYl08sXp9RqqfrdGnBbjtB44JqpxuQoQt7kqwf0JSsjHNWBHhli
         8gFUqFkdGGyKx90hBzdvLF3FNydE/Bs6JxlKR2rg6jH2k8IJTMNahljaTo9TxSSsk3+k
         XWxMc1k4AddqY+KFwXXbYWEEUB4U3twVkD4JEuZbJzaLqcL/bpJSaGypeBEsIgnYsHyE
         Z0+LYekTq8VXWMk4LFk58WxJUXzThyKKexpOeV3EqE0SE40/rw4dWP360cmoY/c6Axao
         1hCw==
X-Gm-Message-State: AGi0PuZxD2v6D2TPn0R0JkeIapAsctCULR348lgtjn9j+DMq+EtOsF6Q
        pXRejWpuUZDsPL++LrV5QeFNL6XRvpDUf7DUaYKGKoLY84AryNDQM5z47ILXcYKvRhP1XmHYFel
        tF0cRmOqUa7uLKhIKLBsUbQ==
X-Received: by 2002:adf:fe87:: with SMTP id l7mr25844137wrr.360.1587476207975;
        Tue, 21 Apr 2020 06:36:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypKlJhAt+4JVl6zumdVZp9Pr5ZIy7Ugt0KD1kpUHwKm7tmzB+uo/O5wVy1Oz0VXjIEvE1GjbyQ==
X-Received: by 2002:adf:fe87:: with SMTP id l7mr25844113wrr.360.1587476207729;
        Tue, 21 Apr 2020 06:36:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id h3sm3705930wrm.73.2020.04.21.06.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 06:36:47 -0700 (PDT)
Subject: Re: [GIT PULL 0/2] KVM: s390: Fix for 5.7 and maintainer update
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20200421063447.6814-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <173f3395-1289-2c38-1afa-f6180e802c84@redhat.com>
Date:   Tue, 21 Apr 2020 15:36:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421063447.6814-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 21/04/20 08:34, Christian Borntraeger wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.7-2

Pulled, thanks.

Paolo

