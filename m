Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0FE1533BE
	for <lists+linux-s390@lfdr.de>; Wed,  5 Feb 2020 16:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgBEPVc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 5 Feb 2020 10:21:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57990 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726416AbgBEPVc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Feb 2020 10:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580916091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jbAqmvDp8yZagHd04oR8JJifOFLKAv/diEDneSy9GDE=;
        b=JGJDkEGpYcMpflBcxpaFKqijMOx2gsV/8eh+CUW8Qfa0EXQMSQc6oAuvzQWKY5vC1k+c7O
        2Wo8dhpE2d4evas8MrMl9jA8EMTCTeq8XQ0tphgAUfHt4qXdNyjQa4ZQpn65BFTCiOxjtw
        gLwVAarWOB3APH4Fs+CEzyMoFKc9fjQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-kSuzztj4MvuzXuLXrq2SGA-1; Wed, 05 Feb 2020 10:15:20 -0500
X-MC-Unique: kSuzztj4MvuzXuLXrq2SGA-1
Received: by mail-wr1-f70.google.com with SMTP id z15so1350448wrw.0
        for <linux-s390@vger.kernel.org>; Wed, 05 Feb 2020 07:15:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jbAqmvDp8yZagHd04oR8JJifOFLKAv/diEDneSy9GDE=;
        b=XJXqmP+aT5NOiJn2Y+bLWTrl7wGG/XVziQ2uiV50HdS5qEc9YhvbQj5fWvJx4ZukMh
         wiOXJmolBhqRR9zfwj2kBnEBW8F3JrmdjtmGToo2jbta/9cRAzwTsSA+llWjpe/cf+3m
         9wYBh7X0whpprqK8n/RBc/JQmRGz0S1YliExZNEluzNvjBLb51CP+897Tnx4iFdAYYZY
         a5vUejlPhnlfIAHxcDaNhqgKHWjmPLlllBip6GO0TAvBTyhtS9Z9JNmzVbRoWD/ydpyg
         p79miRf3wDgZO4SBvvElb3ynqhBa0PIXkfqg9ThSFcr1+DpmIkhulWYfzcLTIFr7AL3B
         vHCg==
X-Gm-Message-State: APjAAAXl4SHrSK5KH8mvoxQ9cQ0ZP/DROiEqEZVMZ9KGcvhy3wG/vmb0
        vyr2Mm307vNPw8qShgcEnP46IvZu9DRj2ZB4DYyx0q+fQe5NT4xmJnjptBxDnFpSiXP1sZwK83N
        JXEGxke6N0jXtCAYstg0Srw==
X-Received: by 2002:adf:cd03:: with SMTP id w3mr30032417wrm.191.1580915718014;
        Wed, 05 Feb 2020 07:15:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxvLhdRSWgM2maQ+SNfiAl7MjWC1I05ytVdRYhXthbKcs88COY/fnHNUifaodKxjXoLAz44eQ==
X-Received: by 2002:adf:cd03:: with SMTP id w3mr30032401wrm.191.1580915717856;
        Wed, 05 Feb 2020 07:15:17 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id x14sm8059396wmj.42.2020.02.05.07.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:15:17 -0800 (PST)
Subject: Re: [GIT PULL 0/7] KVM: s390: Fixes and cleanups for 5.6
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Thomas Huth <thuth@redhat.com>
References: <20200131150348.73360-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cea0211f-5c7c-3838-d682-955e0505c8a4@redhat.com>
Date:   Wed, 5 Feb 2020 16:15:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200131150348.73360-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 31/01/20 16:03, Christian Borntraeger wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.6-1

Pulled, thanks.

Paolo

