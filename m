Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C627146B
	for <lists+linux-s390@lfdr.de>; Sun, 20 Sep 2020 15:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgITNPa (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 20 Sep 2020 09:15:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37707 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726321AbgITNP3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 20 Sep 2020 09:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600607728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOcc4Mm2oqlSQPWb1TVwH0AOnNOAOKb7pgUNdANwl2s=;
        b=K3EOU7gJeKbR6vDVjzzTVTTZy1VeqiFcUo9HibkRtZS4Up3p6t16m++2Nc55gN0Rwuqtkv
        ASyLE7pIM2QxGmqGQ3G9E6pLBuMiaexHIeyNmoEGERKyJb/ooDwxU740osKGmq9thDsgmp
        VgEmLNnaKPonfjIoV51+iA92tQ9e+yU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-pmsHP-xnNYefVuu1GkZzHg-1; Sun, 20 Sep 2020 09:14:22 -0400
X-MC-Unique: pmsHP-xnNYefVuu1GkZzHg-1
Received: by mail-wr1-f69.google.com with SMTP id a10so4549366wrw.22
        for <linux-s390@vger.kernel.org>; Sun, 20 Sep 2020 06:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kOcc4Mm2oqlSQPWb1TVwH0AOnNOAOKb7pgUNdANwl2s=;
        b=clP4JhLDjLhpzSTby2JJcvmHNDXOszjjeRRbrur7HH6GySX/0c3IJweuniwF0hJusZ
         HbYDup4XivwqK8TJneRLZytegeRO9l4OttvuRj35jImK/xzxbB2Nbw70YTjY4OT4BA5U
         p6WheQ9c2JLXQ+saL49HHhhPRhlNbdVVBhHIThrsxu2+E+aTZcsXkklF9sZ0Q7p5tPDZ
         TEU4+IDLc0WMLwVL+9U1gNRUGpUp0Vb3aaAMsdOAmFxA0vaeEH+5aINmuHJudVS3LQut
         r70cNZGP/Fu2X/sOcZkTLz4DFtTlSVoEY0OnxLbmxS19LlPRRYQGnjjDJCFMhoVK7GfF
         Q+PQ==
X-Gm-Message-State: AOAM533Cd/7wb4xYpgKRnsbQ20kv3vCNjam0NxkUadJgWidsJFulKh65
        llcfTW3OsUiFIqmhhk0f0i19D6eRMwIHACtIUkpMDaP//uh9P57VhiD3r2DE2niRRMJqB+SgsK1
        WBO+y1wRMSkeuYbspQqUgYg==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr26228053wmm.38.1600607661005;
        Sun, 20 Sep 2020 06:14:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUeDeq9buCfzas3mmxEHjvbpu2G8sbbtzgUysbCbQ9WgOczZOBJK8Ha4p01Xx+NUyhoWq6og==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr26228046wmm.38.1600607660832;
        Sun, 20 Sep 2020 06:14:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:458b:b280:cf0:4acf? ([2001:b07:6468:f312:458b:b280:cf0:4acf])
        by smtp.gmail.com with ESMTPSA id c16sm16544358wrx.31.2020.09.20.06.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 06:14:20 -0700 (PDT)
Subject: Re: [GIT PULL 0/1] KVM: s390: add documentation for
 KVM_CAP_S390_DIAG318 (5.9)
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Collin Walling <walling@linux.ibm.com>
References: <20200914082215.6143-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ae636410-520c-2426-7269-67d78c4a8e7a@redhat.com>
Date:   Sun, 20 Sep 2020 15:14:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914082215.6143-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14/09/20 10:22, Christian Borntraeger wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.9-1

Pulled, thanks.

Paolo

