Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9831C4062
	for <lists+linux-s390@lfdr.de>; Mon,  4 May 2020 18:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgEDQpI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 4 May 2020 12:45:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49921 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729395AbgEDQpH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 12:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588610706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RgNAr5ePUPXCOlMMjdyI2n+4U4LTYkHptNR+Gklm4AM=;
        b=PbCQN7Qt1KiMmVqXGpg/ts5Hpy3CDFOiBBTTbh7lGRYPfBwDzlJT2h7xzNiy9QY0vX0SsF
        RjLwEY1gv7Dg9wXZTTHyromh7iaRqKDVOtjkoackJ9piau7RHCXT3Vp4wml9cQcmfJS4D4
        h41RFUVyhLHvQ7sDEQh9I0u2Ob4gZoI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-wbwvHBPIOvym7vrLKKKAVQ-1; Mon, 04 May 2020 12:44:59 -0400
X-MC-Unique: wbwvHBPIOvym7vrLKKKAVQ-1
Received: by mail-wr1-f71.google.com with SMTP id f15so6201wrj.2
        for <linux-s390@vger.kernel.org>; Mon, 04 May 2020 09:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RgNAr5ePUPXCOlMMjdyI2n+4U4LTYkHptNR+Gklm4AM=;
        b=jVsWc0T9hb6L+Q5yrnMkqXaIiC9GzgBbxMoWxXdypzFc8aaY4Vg/UMqojWx73dnSi3
         CIYU5YrqR26Aq56D5ioguMfkLUMMxuXxhdNwA68IpxMAyDxVa5315mhMq7DlApQjn16a
         IYh+/hllxgkYb5frkFQ5bYDJtRyo81peOlNxZOPAcGJatNA48wx65zhEJveCQUB+UjKj
         gPVMhw0L+XlhakUPJYe6QZLf7666LKUOT0PxTh6Tz5XGvHMXst9Q8WY+UhmCT9Imc8y5
         bTGHSOXWBGYBlYfZbGiIJYdLS/nchj8kzMqTLsScqlGAcxaPcwWM+P9ycEF5f/SYI5it
         S5fg==
X-Gm-Message-State: AGi0PuZCOiIbcbFbhoTybA7eO2yZ7FXlWGnAvWvXdi9IUFvoELLFEoxn
        PRxtmdO5+wqh/UjC8cXMEuNkqJkIlgJmOk9pcSsF6UFPvrTPzqiXaM12E9S0Rzk0HJdPvtWoTcR
        PM1DChkU1e+eMXVx17NnO9w==
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr15643701wmm.104.1588610698594;
        Mon, 04 May 2020 09:44:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypKAceuiic+rg2tWFVV1HrVcmieBoZp9SufVEvQbCPNh1/dooxyE98gmWg3zzUAgW98Do+zfDg==
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr15643675wmm.104.1588610698405;
        Mon, 04 May 2020 09:44:58 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id y11sm18766137wrh.59.2020.05.04.09.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 09:44:57 -0700 (PDT)
Subject: Re: [kvm-unit-tests PULL 00/17] s390x updates
To:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc:     Thomas Huth <thuth@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-s390@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@de.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>
References: <20200430152430.40349-1-david@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7ff41e72-06e7-efc1-9e74-3709340c1135@redhat.com>
Date:   Mon, 4 May 2020 18:44:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200430152430.40349-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 30/04/20 17:24, David Hildenbrand wrote:
>   https://github.com/davidhildenbrand/kvm-unit-tests.git tags/s390x-2020-04-30

Pulled, thanks.

Paolo

