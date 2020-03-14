Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 505701859DF
	for <lists+linux-s390@lfdr.de>; Sun, 15 Mar 2020 04:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgCODwX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 14 Mar 2020 23:52:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44978 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726653AbgCODwX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 14 Mar 2020 23:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584244342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cams43BRaSryQXKzOLgz59jXTIRFKFLmhG2spAnZE4k=;
        b=Ew4pGiu73ujSUP8O4RXkcbMTrCE7wNBidJCixw8QKtYczc5H52ZGckeGsoG4MJPHvFw5eY
        oVQqZyyk0mWRlqzT5BjTvn6Qgg9jEAe2jO6KkopaL9cGDHeF3VkvqfOfBRAy45/S/A6RDF
        t85xcyrd6649Cn+hlp0JEG+ct1aCyQM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-J9TpRPn5MMyAfG8b5H2rUA-1; Sat, 14 Mar 2020 07:48:04 -0400
X-MC-Unique: J9TpRPn5MMyAfG8b5H2rUA-1
Received: by mail-wr1-f72.google.com with SMTP id c6so5796176wrm.18
        for <linux-s390@vger.kernel.org>; Sat, 14 Mar 2020 04:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cams43BRaSryQXKzOLgz59jXTIRFKFLmhG2spAnZE4k=;
        b=ZBpOEV2xI6WxsfqPq5+/u/B6mIKOB8BiBJDugdjJNPLJYDVTcSzxZkwIQfPr4o1jnA
         DDBAs5W85+a3eLRDl0gt46h/3Y8Av8UEq2IeEW0FpCn4/FIErw5kzXSGxpD4G5JIm0g0
         jNX3Zvb+Mnflmpe6JIhQDVFMtoQHlATlpOWbRk2kkOZvISbmvA14LREUTFowk/UXjv2V
         Zj8YOCtkt98HVyV8OPcOJ6xDkqM2KhnneL2anEG9DN/Z/a4x5PFwWbjo2YcJwhuQzmw/
         CUyxPqFtFRD5z5QQlqOl+IJVRA8DmlHp5GVLgbDaQMMqiGytrAq6mTt77m6p4FdYh/Ix
         7HMQ==
X-Gm-Message-State: ANhLgQ2HT8I9Zy3FDqy23fMEAqgNHsJjeWNtqP9VZ5Hus8qRBR1opG4F
        TD2l9Ek6f9dQhPwwVXypvx1Ezf++DOhnHe9VjXZVz2aN2XfkVIzcOrj8dZStISRVQ7OyFhPGsMh
        VK17qbcLZshZxeIygUWRb5A==
X-Received: by 2002:adf:82ee:: with SMTP id 101mr23493127wrc.7.1584186483718;
        Sat, 14 Mar 2020 04:48:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv/exKCAnUJBy9dNlX2Ewgz1LAYenF4P9VYNNHkRNx1Cwdkk6TKpo/sMt98U/CeHR8RncElrQ==
X-Received: by 2002:adf:82ee:: with SMTP id 101mr23493112wrc.7.1584186483449;
        Sat, 14 Mar 2020 04:48:03 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.174.5])
        by smtp.gmail.com with ESMTPSA id w4sm32809119wrl.12.2020.03.14.04.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2020 04:48:02 -0700 (PDT)
Subject: Re: [PATCH 0/5] selftests: KVM: s390: Accumulated fixes and
 extensions
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <20200310130144.9921-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d09a198-ba35-1591-6a79-57f336e2f1c5@redhat.com>
Date:   Sat, 14 Mar 2020 12:48:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310130144.9921-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/03/20 14:01, Christian Borntraeger wrote:
> - do more and better testing for reset
> - fix fprintf formats (thanks to Andrew Jones)
> 
> Paolo, I would schedule this for next and not for master. ok?
> 
> Christian Borntraeger (5):
>   selftests: KVM: s390: fix early guest crash
>   selftests: KVM: s390: test more register variants for the reset ioctl
>   selftests: KVM: s390: check for registers to NOT change on reset
>   selftests: KVM: s390: fixup fprintf format error in reset.c
>   selftests: KVM: s390: fix format strings for access reg test
> 
>  tools/testing/selftests/kvm/s390x/resets.c    | 132 ++++++++++++++----
>  .../selftests/kvm/s390x/sync_regs_test.c      |  11 +-
>  2 files changed, 116 insertions(+), 27 deletions(-)
> 

Queued, thanks.  I pulled the format strings fixes before -Wformat is
enabled.

Paolo

