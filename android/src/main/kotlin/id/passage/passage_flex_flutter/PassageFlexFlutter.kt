package id.passage.passage_flex_flutter

import android.app.Activity
import android.os.Build
import com.google.gson.Gson
import id.passage.android.passageflex.model.AuthenticatorAttachment
import id.passage.passageflex.PassageFlex
import id.passage.passageflex.exceptions.AuthenticateCredentialException
import id.passage.passageflex.exceptions.AuthenticateDiscoverableLoginException
import id.passage.passageflex.exceptions.AuthenticateInvalidRequestException
import id.passage.passageflex.exceptions.RegisterCredentialException
import id.passage.passageflex.exceptions.RegisterInvalidRequestException
import id.passage.passageflex.models.PasskeyCreationOptions
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

internal class PassageFlexFlutter(activity: Activity, appId: String) {

    private val passage: PassageFlex = PassageFlex(activity, appId)

    internal companion object {
        internal fun invalidArgumentError(result: MethodChannel.Result) {
            result.error(
                PassageFlutterError.INVALID_ARGUMENT.name, "Invalid or missing argument", null
            )
        }
    }

    internal fun register(call: MethodCall, result: MethodChannel.Result) {
        val transactionId = call.argument<String>("transactionId") ?: return invalidArgumentError(result)
        val optionsMap = call.argument<Map<String, String>>("passkeyCreationOptions")
        val attachmentValue = optionsMap?.get("authenticatorAttachment")

        val authenticatorAttachment = when (attachmentValue) {
            "platform" -> AuthenticatorAttachment.platform
            "cross-platform" -> AuthenticatorAttachment.crossMinusPlatform
            "any" -> AuthenticatorAttachment.any
            else -> AuthenticatorAttachment.platform
        }
        val passkeyCreationOptions = PasskeyCreationOptions(authenticatorAttachment)

        CoroutineScope(Dispatchers.IO).launch {
            try {
                val nonce = passage.passkey.register(transactionId, passkeyCreationOptions)
                result.success(nonce)
            } catch (e: Exception) {
                val error = when (e) {
                    is RegisterInvalidRequestException -> {
                        PassageFlutterError.INVALID_REQUEST
                    }
                    is RegisterCredentialException -> {
                        PassageFlutterError.WEB_AUTH_FAILED
                    }
                    else -> PassageFlutterError.PASSKEY_ERROR
                }
                result.error(error.name, e.message, e.toString())
            }
        }
    }

    internal fun authenticate(call: MethodCall, result: MethodChannel.Result) {
        val transactionId = call.argument<String>("transactionId") ?: return invalidArgumentError(result)
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val nonce = passage.passkey.authenticate(transactionId)
                result.success(nonce)
            } catch (e: Exception) {
                val error = when (e) {
                    is AuthenticateInvalidRequestException -> {
                        PassageFlutterError.INVALID_REQUEST
                    }
                    is AuthenticateDiscoverableLoginException -> {
                        PassageFlutterError.DISCOVERABLE_LOGIN_FAILED
                    }
                    is AuthenticateCredentialException -> {
                        PassageFlutterError.WEB_AUTH_FAILED
                    }


                    else -> PassageFlutterError.PASSKEY_ERROR
                }
                result.error(error.name, e.message, e.toString())
            }
        }
    }

}