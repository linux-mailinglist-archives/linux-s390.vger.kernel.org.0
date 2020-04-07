Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8C431A0DA7
	for <lists+linux-s390@lfdr.de>; Tue,  7 Apr 2020 14:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgDGMbp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 7 Apr 2020 08:31:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49038 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728146AbgDGMbo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Apr 2020 08:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586262703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cf6HeBCxjUruxoGI91yxHPOxsiwFayWbRoQQU5L19fY=;
        b=PW9JO+5hMY7u5XcsQRZxIdWHS5uO3EoS6oAllLzTcZzMHFj9KDWL1kebuzJuzLkuTzUiUC
        wG+g6oB6ZcX0m3cLHrrcRK6OjkBsnCjNzJ5eOJCToumgPRwq/9OEUaEeYFCo0ntWOLCMCX
        2qy1RabVAkLijgroPH+ccCpXpzw278I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-ZoSAN-ttPNmMs0ox1X3k1w-1; Tue, 07 Apr 2020 08:31:42 -0400
X-MC-Unique: ZoSAN-ttPNmMs0ox1X3k1w-1
Received: by mail-wr1-f72.google.com with SMTP id u16so1696321wrp.14
        for <linux-s390@vger.kernel.org>; Tue, 07 Apr 2020 05:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cf6HeBCxjUruxoGI91yxHPOxsiwFayWbRoQQU5L19fY=;
        b=CLDKwb72s/q+o0nKZuD+3ZV4zrp8cIplAj9VhgoUM2dZfAtPTWo3f0VQ9+b5sib0/y
         B5QpesX5KzLC5O9a0NLxvgrKLNid+JOIXMilTE9ho/KC+vWyk6oqP2Y3aSE2IhC97FP3
         aDUxd8//RQNZeZtv8nddrJ53DbCO4cIfSBY6ij5TgxjqmSWRh0Irx+XFeJc0veEEnmYP
         a3bDmLF5z+DNsGZn1/NC79Jj3wkdUUmk/upJn9ovm1IWiLK72s5lSewb6EtFcLs6vGj9
         DEk1EOcwwyVNmfZN2VXXf7BRMMAWvcVClYMoZ9dmbtBUA27yBVP2MNM+BkEUFCEw3IOI
         iqpg==
X-Gm-Message-State: AGi0PualrwShtHuE8QQZkrfTMEEE8tg1SWudzOsNPaLNx8O0UtnowVNz
        sLuBYLMJ4/JwAIki5UHce1sfBYYEWGCLRQbRMSSHmR2lmMWf0GoKYscqNR7pgXifG1czNQzenCN
        rGuf6rGAW0xivK6daVgfJZg==
X-Received: by 2002:adf:f4cc:: with SMTP id h12mr2501447wrp.171.1586262701001;
        Tue, 07 Apr 2020 05:31:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypLANV6ylf8gqaJS0lQU1t8GvWYfkTU8ZNu5aQ3z7vaNssQcTd5L1/eQrY2HblkUGGXPtLF3yQ==
X-Received: by 2002:adf:f4cc:: with SMTP id h12mr2501423wrp.171.1586262700731;
        Tue, 07 Apr 2020 05:31:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bd61:914:5c2f:2580? ([2001:b07:6468:f312:bd61:914:5c2f:2580])
        by smtp.gmail.com with ESMTPSA id t11sm30316985wru.69.2020.04.07.05.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 05:31:40 -0700 (PDT)
Subject: Re: [GIT PULL 0/3] KVM: s390: Fixes for vsie (nested hypervisors)
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <20200407114240.156419-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b9689a91-9df1-9e37-03b7-156691f1ccd4@redhat.com>
Date:   Tue, 7 Apr 2020 14:31:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200407114240.156419-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 07/04/20 13:42, Christian Borntraeger wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.7-1

Pulled, thanks!

Paolo

