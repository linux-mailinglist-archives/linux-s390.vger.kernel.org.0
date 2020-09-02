Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8596A25B315
	for <lists+linux-s390@lfdr.de>; Wed,  2 Sep 2020 19:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBRlt (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 2 Sep 2020 13:41:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36878 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727088AbgIBRlo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Sep 2020 13:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599068502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6xAT+ftsMSzlsQJaTtQj9xlDJAYlVlX6xJr8D9dNUi0=;
        b=d9+5B6yWlkASnqh1Y1CJ1SrTxZQcksHSs12TEg+B3pOjRXUIR/IKQ2sK4LuKJBT6hVfUYF
        43YBEGPM9VYOFFhEdJyQ0OwVIK1qW0sH86k77cLnaXlc5LWhBOmAP4uKWuiB6R2S+ykSzA
        w+Ha9SLQh+ccjsBxtEkLVV5QyEwZmv4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-CYKDd0EaMVeQIZhGDh8Tjg-1; Wed, 02 Sep 2020 13:41:38 -0400
X-MC-Unique: CYKDd0EaMVeQIZhGDh8Tjg-1
Received: by mail-wr1-f71.google.com with SMTP id b8so2375047wrr.2
        for <linux-s390@vger.kernel.org>; Wed, 02 Sep 2020 10:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6xAT+ftsMSzlsQJaTtQj9xlDJAYlVlX6xJr8D9dNUi0=;
        b=Cebv4yQxO9SBhVKRibUhjiZNZExdD/ctTbnIjK3ZJMmjey8Z3h9UO9YRYqL+e2kTo6
         Iv6SHeCCo2fzPEbHhEvGJz87QlNPVmt5WD+cKDllITUktkvrYT1AKJrmoOIsTI2Y0eDD
         uHqLrvqBalCToeZfdVBF7a0Vq8R216TPw+OWzauT303wnjnCkPObbNx3r6FDCZvVYnCU
         DoQa5iYYO/udjV+BwhPHz7mkFeAu1ZU6eixrd0DORZLkqT2Qa/SWqIPJ+wUAbPBYpTql
         JPzUZAMsilf/l4oVodhQA3aO1DSWypnwSpAaGFEZYfAms4FjBZTSZOMa+IWS4bc9mSYf
         2YHw==
X-Gm-Message-State: AOAM530d8ZnU6TC2DGjayHrvAAJU6CoyIlvU8C2KsJzP+zrprxUDBkhk
        TZPARn9gmr32yPK2iURrX6iMkdpCxFEuYLFltkhuBIWrQQwPTyI5SWUpOVH/cpvRI965TjatrjL
        8VG41qlUEAS3Y0bPt1di2qQ==
X-Received: by 2002:a1c:f30f:: with SMTP id q15mr1732071wmq.60.1599068497784;
        Wed, 02 Sep 2020 10:41:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJI4/fSfohZhzg0zq2mOil1DcOIoF66i9w6QgGSiGMttgmkpJk+kP5A0dUG4eAzfWa19MfuA==
X-Received: by 2002:a1c:f30f:: with SMTP id q15mr1732054wmq.60.1599068497518;
        Wed, 02 Sep 2020 10:41:37 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.193])
        by smtp.gmail.com with ESMTPSA id j7sm601707wrw.35.2020.09.02.10.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 10:41:37 -0700 (PDT)
Subject: Re: [kvm-unit-tests GIT PULL 0/3] s390x skrf and ultravisor patches
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
References: <20200901091823.14477-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34c80837-208f-bb29-cb0b-b9029fdad29d@redhat.com>
Date:   Wed, 2 Sep 2020 19:41:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901091823.14477-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 01/09/20 11:18, Janosch Frank wrote:
>   git@gitlab.com:frankja/kvm-unit-tests.git tags/s390x-2020-01-09

Pulled, thanks.

(Yes, I am alive).

Paolo

